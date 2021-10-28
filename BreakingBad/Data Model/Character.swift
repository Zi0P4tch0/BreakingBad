import Foundation
import RealmSwift
import Resolver

struct Character {
    let id: Int
    let name: String
    let birthday: Date?
    let occupation: [String]
    let image: URL
    let status: String
    let appearance: [Int]
    let nickname: String
    let portrayedBy: String
    let liked: Bool
}

// MARK: - Decodable

extension Character: Decodable {

    enum DecodingError: Error {
        case invalidImageURL(String)
    }

    private enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case image = "img"
        case status
        case appearance
        case nickname
        case portrayedBy = "portrayed"
    }

    init(from decoder: Decoder) throws {

        @Injected(name: .birthdayDateFormatter)
        var birthdayDateFormatter: DateFormatter

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        name = try container.decode(.name)
        let birthDate: String = try container.decode(.birthday)
        birthday = birthdayDateFormatter.date(from: birthDate)
        occupation = try container.decode(.occupation)
        let imageURLString: String = try container.decode(.image)
        guard let imageURL = URL(string: imageURLString) else {
            throw DecodingError.invalidImageURL(imageURLString)
        }
        image = imageURL
        status = try container.decode(.status)
        appearance = try container.decode(.appearance)
        nickname = try container.decode(.nickname)
        portrayedBy = try container.decode(.portrayedBy)
        // Restore the liked status of the character (if it's in the database)
        guard let realm = try? Realm(),
              let existingChar = realm.object(ofType: RealmCharacter.self, forPrimaryKey: id) else {
            liked = false
            return
        }
        liked = existingChar.liked
    }

}

// MARK: - Equatable

extension Character: Equatable { }
