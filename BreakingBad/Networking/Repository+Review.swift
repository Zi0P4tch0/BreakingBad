import Foundation

protocol ReviewRepositoryType {
    func review(character: Character, with payload: Review) -> Single<Nothing>
}

// MARK: - Repository + ReviewRepositoryType

extension Repository {

    func review(character: Character, with payload: Review) -> Single<Nothing> {
        response(Router.review(character: character, payload: payload))
    }

}
