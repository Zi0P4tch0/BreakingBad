import Foundation

struct Review: Encodable {
    let name: String
    let watched: Date
    let text: String
    let rating: Int
}
