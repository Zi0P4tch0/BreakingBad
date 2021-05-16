import Foundation

final class RealmQuote: Object {

    override class func primaryKey() -> String? {
        "id"
    }

    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var author: RealmCharacter?

}

// MARK: - RealmQuote from Quote

extension RealmQuote {

    convenience init(quote: Quote, character: Character) {
        self.init()
        id = quote.id
        text = quote.text
        author = try? Realm().object(ofType: RealmCharacter.self, forPrimaryKey: character.id)
    }

}

// MARK: - RealmQuote to Quote

extension RealmQuote {

    func toValue() -> Quote {
        Quote(id: id,
              text: text,
              author: author?.name ?? R.string.localizable.genericUnknown())
    }

}
