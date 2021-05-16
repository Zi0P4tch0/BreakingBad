import Foundation
import UIKit

struct Quote {
    let id: Int
    let text: String
    let author: String
}

// MARK: - Quote + Decodable

extension Quote: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case text = "quote"
        case author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        text = try container.decode(.text)
        author = try container.decode(.author)
    }

}

// MARK: - Quote + Equatable

extension Quote: Equatable { }
