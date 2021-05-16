import Foundation

enum Router {

    enum Method: String {
        case get = "GET"
        case post = "POST"
    }

    // swiftlint:disable:next force_unwrapping
    private static let baseURL = URL(string: "https://www.breakingbadapi.com/api")!

    // MARK: Endpoints

    case allCharacters
    case allQuotes(character: Character)
    case review(character: Character, payload: Review)

}

extension Router {

    var url: URL {
        switch self {
        case .allCharacters:
            return Router.baseURL.appendingPathComponent("/characters")
        case let .allQuotes(character):
            let url = Router.baseURL.appendingPathComponent("/quote")
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            // swiftlint:disable force_unwrapping
            components!.queryItems = [URLQueryItem(name: "author", value: character.name)]
            return components!.url!
            // swiftlint:enable force_unwrapping

        case let .review(character, _):
            return Router.baseURL.appendingPathComponent("/review/\(character.id)")
        }
    }

    var method: Method {
        switch self {
        case .allCharacters, .allQuotes:
            return .get
        case .review:
            return .post
        }
    }

    var body: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        switch self {
        case let .review(_, payload):
            return try? encoder.encode(payload)
        default:
            return nil
        }
    }

}

// MARK: - Router + URLRequestConvertible

extension Router: URLRequestConvertible {

    func toURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let body = body {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        }
        return request
    }

}
