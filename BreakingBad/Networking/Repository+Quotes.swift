import Foundation
import RxSwift

protocol QuoteRepositoryType {
    func allQuotes(for character: Character) -> Single<[Quote]>
}

// MARK: - QuoteRepositoryType

extension Repository {

    func allQuotes(for character: Character) -> Single<[Quote]> {
        response(Router.allQuotes(character: character))
    }

}
