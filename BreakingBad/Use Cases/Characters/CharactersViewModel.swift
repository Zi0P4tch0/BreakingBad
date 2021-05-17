import Foundation
import RxRealm

// MARK: - Outputs

protocol CharactersViewModelOutputs {
    var title: Driver<String> { get }
    var emptyText: Driver<String> { get }
    var tableViewAlpha: Driver<CGFloat> { get }
    var characters: Driver<[Character]> { get }
}

// MARK: - Inputs

protocol CharactersViewModelInputs {
    var viewDidLoad: PublishSubject<Void> { get }
}

// MARK: - Protocol

protocol CharactersViewModelType {
    var outputs: CharactersViewModelOutputs { get }
    var inputs: CharactersViewModelInputs { get }
}

// MARK: - Implementation

final class CharactersViewModel: CharactersViewModelType,
                                 CharactersViewModelOutputs,
                                 CharactersViewModelInputs {

    var outputs: CharactersViewModelOutputs { self }
    var inputs: CharactersViewModelInputs { self }

    // MARK: Outputs

    let title: Driver<String> = .just(Strings.charactersTitle())
    let characters: Driver<[Character]>
    let emptyText: Driver<String> = .just(Strings.charactersEmpty())
    let tableViewAlpha: Driver<CGFloat>

    // MARK: Inputs

    let viewDidLoad = PublishSubject<Void>()

    // MARK: Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    init(charactersRepository: CharacterRepositoryType) {

        // Refresh the characters' database when the view loads
        viewDidLoad.flatMap {
            charactersRepository.allCharacters()
        }
        .map { $0.map { RealmCharacter.init(character: $0) } }
        .bind(to: Realm.rx.add(update: .all))
        .disposed(by: disposeBag)

        // Display the characters from the database
        guard let storedCharacters = try? Realm().objects(RealmCharacter.self)
            .sorted(byKeyPath: "name")
            .sorted(byKeyPath: "liked", ascending: false) else {
            fatalError("Could not retrieve stored characters")
        }

        characters = Observable.collection(from: storedCharacters)
            .map { $0.map { $0.toValue() } }
            .asDriver(onErrorJustReturn: [])

        tableViewAlpha = characters.map { $0.isEmpty ? 0 : 1 }

    }

}
