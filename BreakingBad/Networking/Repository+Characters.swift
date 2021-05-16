import Foundation

protocol CharacterRepositoryType {
    func allCharacters() -> Single<[Character]>
}

// MARK: - Repository + CharacterRepositoryType

extension Repository {

    func allCharacters() -> Single<[Character]> {
        response(Router.allCharacters)
    }

}
