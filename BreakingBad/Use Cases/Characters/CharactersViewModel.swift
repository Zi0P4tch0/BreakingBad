import Foundation
import RxRealm

protocol CharactersViewModelOutputs {
    var title: Driver<String> { get }
    var characters: Driver<[Character]> { get }
}

protocol CharactersViewModelInputs {
    var viewDidLoad: PublishSubject<Void> { get }
}

protocol CharactersViewModelType {
    var outputs: CharactersViewModelOutputs { get }
    var inputs: CharactersViewModelInputs { get }
}

final class CharactersViewModel: CharactersViewModelType,
                                 CharactersViewModelOutputs,
                                 CharactersViewModelInputs {

    var outputs: CharactersViewModelOutputs { self }
    var inputs: CharactersViewModelInputs { self }

    // MARK: - Outputs

    let title: Driver<String> = .just(R.string.localizable.charactersTitle())
    let characters: Driver<[Character]>

    // MARK: - Inputs

    let viewDidLoad = PublishSubject<Void>()

    // MARK: - Private

    private let disposeBag = DisposeBag()

    init(charactersRepository: CharacterRepositoryType) {

        // Refresh the list of characters when the view loads
        viewDidLoad.flatMap {
            charactersRepository.allCharacters()
        }
        .map { $0.map { RealmCharacter.init(character: $0) } }
        .subscribe(onNext: { characters in
            guard let realm = try? Realm() else { return }
            try? realm.write {
                realm.add(characters, update: .all)
            }
        })
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

    }

}
