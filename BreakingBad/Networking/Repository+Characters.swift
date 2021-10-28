import Foundation
import RxSwift

protocol CharacterRepositoryType {
    func allCharacters() -> Single<[Character]>
}

// MARK: - CharacterRepositoryType

extension Repository {

    func allCharacters() -> Single<[Character]> {
        response(Router.allCharacters)
    }

}
