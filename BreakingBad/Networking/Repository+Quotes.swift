protocol QuoteRepositoryType {
    func allQuotes(for character: Character) -> Single<[Quote]>
}

// MARK: - Repository + QuoteRepositoryType

extension Repository {

    func allQuotes(for character: Character) -> Single<[Quote]> {
        response(Router.allQuotes(character: character))
    }

}
