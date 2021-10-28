import Foundation
import RxSwift

protocol ReviewRepositoryType {
    func review(character: Character, with payload: Review) -> Single<Nothing>
}

// MARK: - ReviewRepositoryType

extension Repository {

    func review(character: Character, with payload: Review) -> Single<Nothing> {
        response(Router.review(character: character, payload: payload))
    }

}
