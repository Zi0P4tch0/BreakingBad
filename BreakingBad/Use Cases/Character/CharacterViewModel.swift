import RealmSwift
import Resolver
import RxCocoa
import RxSwift
import UIKit

// MARK: - Outputs

protocol CharacterViewModelOutputs {
    var title: Driver<String> { get }
    var isImageLoading: Driver<Bool> { get }
    var image: Driver<UIImage?> { get }
    var birthday: Driver<NSAttributedString> { get }
    var occupation: Driver<NSAttributedString> { get }
    var status: Driver<NSAttributedString> { get }
    var nickname: Driver<NSAttributedString> { get }
    var portrayedBy: Driver<NSAttributedString> { get }
    var seasons: Driver<NSAttributedString> { get }
    var quotes: Driver<NSAttributedString> { get }
    var likeButtonHighlighted: Driver<Bool> { get }
    var presentReview: Driver<Character> { get }
}

// MARK: - Inputs

protocol CharacterViewModelInputs {
    var viewDidLoad: PublishSubject<Void> { get }
    var likeButtonTapped: PublishSubject<Void> { get }
    var reviewTapped: PublishSubject<Void> { get }
}

// MARK: - Protocol

protocol CharacterViewModelType {
    var outputs: CharacterViewModelOutputs { get }
    var inputs: CharacterViewModelInputs { get }
}

// MARK: - Implementation

final class CharacterViewModel: CharacterViewModelType,
                                CharacterViewModelOutputs,
                                CharacterViewModelInputs {

    var outputs: CharacterViewModelOutputs { self }
    var inputs: CharacterViewModelInputs { self }

    // MARK: Outputs

    let title: Driver<String>
    let image: Driver<UIImage?>
    let birthday: Driver<NSAttributedString>
    let occupation: Driver<NSAttributedString>
    let status: Driver<NSAttributedString>
    let nickname: Driver<NSAttributedString>
    let portrayedBy: Driver<NSAttributedString>
    let seasons: Driver<NSAttributedString>
    let quotes: Driver<NSAttributedString>
    let likeButtonHighlighted: Driver<Bool>
    let presentReview: Driver<Character>
    let isImageLoading: Driver<Bool>

    // MARK: Inputs

    let viewDidLoad = PublishSubject<Void>()
    let likeButtonTapped = PublishSubject<Void>()
    let reviewTapped = PublishSubject<Void>()

    // MARK: Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    // swiftlint:disable:next function_body_length
    init(character: Character) {

        let imageService: ImageServiceType = resolve()
        let quoteRepository: QuoteRepositoryType = resolve()
        let birthdayDateFormatter: DateFormatter = resolve(.birthdayDateFormatter)

        let formatter = CharacterViewModel.attributedString(boldPart:normalPart:)

        title = .just(character.name)

        let imageShared =
            imageService.fetchImage(url: character.image)
                .asObservable()
                .startWith(nil)
                .asDriver(onErrorJustReturn: nil)

        image = imageShared

        isImageLoading = imageShared.map { $0 == nil }

        let birthDate =
            character.birthday.map {
                birthdayDateFormatter.string(from: $0)
            } ?? "character.birthday.unknown".localized()

        birthday = .just(
            formatter("character.birthday".localized(), birthDate)
        )

        occupation = .just(
            formatter("character.occupation".localized(),
                      character.occupation.joined(separator: "\n"))
        )

        status = .just(
            formatter("character.status".localized(), character.status)
        )

        nickname = .just(
            formatter("character.nickname".localized(), character.nickname)
        )

        portrayedBy = .just(
            formatter("character.portrayedBy".localized(), character.portrayedBy)
        )

        seasons = .just(
            formatter("character.seasons".localized(),
                      character.appearance.map { "\($0)" }.joined(separator: ", "))
        )

        // Refresh quotes when the view loads
        viewDidLoad.flatMap {
            quoteRepository.allQuotes(for: character)
        }
        .map { $0.map { RealmQuote.init(quote: $0, character: character) } }
        .bind(to: Realm.rx.add(update: .all))
        .disposed(by: disposeBag)

        // Retrieve the stored quotes
        guard let storedQuotes = try? Realm().objects(RealmQuote.self)
                                             .filter("author.name = \"\(character.name)\"") else {
            fatalError("Could not retrieve stored quotes for character \"\(character.name)\"")
        }

        // Format them
        let formattedQuotes =
            Observable.collection(from: storedQuotes)
            .map { $0.map { $0.toValue().attributedString } }
            .map {
                // Show an alternative message in case there are no quotes.
                $0.isEmpty ?
                [NSAttributedString(string: "character.noQuotes".localized(),
                                        attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                                     .foregroundColor: UIColor.systemGray])] :
                $0
            }
            .map {
                // Concat the attributed strings
                $0.reduce(NSMutableAttributedString()) { (element: NSMutableAttributedString,
                                                          // swiftlint:disable:next closure_parameter_position
                                                          next: NSAttributedString) -> NSMutableAttributedString in
                    element.append(next)
                    element.append(NSAttributedString(string: "\n\n"))
                    return element
                }
            }

        quotes = formattedQuotes.map { $0 as NSAttributedString }
                                .asDriver(onErrorJustReturn: NSAttributedString())

        // Update the like button
        guard let storedCharacter = try? Realm().objects(RealmCharacter.self)
                                                .filter("name = \"\(character.name)\"") else {
            fatalError("Could not retrieve stored character \"\(character.name)\"")
        }

        likeButtonHighlighted = Observable.collection(from: storedCharacter)
                                .compactMap { $0.first }
                                .map { $0.liked }
                                .asDriver(onErrorJustReturn: false)

        // Like logic

        likeButtonTapped
            .subscribe(onNext: { _ in
                guard let character = try? Realm().object(ofType: RealmCharacter.self,
                                                   forPrimaryKey: character.id) else {
                    debugPrint("Could not retrieve stored character \"\(character.name)\"")
                    return
                }
                do {
                    try Realm().write {
                        character.liked.toggle()
                    }
                } catch {
                    // swiftlint:disable:next line_length
                    debugPrint("Could not toggle liked status on character \"\(character.name)\": \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)

        // Present review
        presentReview = reviewTapped.map { _ in character }
                                    .asDriver(onErrorJustReturn: character)

    }

}

// MARK: - Utilities

extension CharacterViewModel {

    static func attributedString(boldPart: String, normalPart: String) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: boldPart,
                                      attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributedString.append(
            NSAttributedString(string: normalPart,
                               attributes: [.font: UIFont.systemFont(ofSize: 16)])
        )
        return attributedString
    }

}

// MARK: - Quote + Attributed String Representation

extension Quote {

    var attributedString: NSAttributedString {
        NSAttributedString(string: "\"\(text)\"",
                           attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                        .foregroundColor: UIColor.systemGray])
    }

}
