import Foundation

struct Nothing: Decodable { }

// MARK: - Protocol
protocol RepositoryType: CharacterRepositoryType,
                         QuoteRepositoryType,
                         ReviewRepositoryType {

}

// MARK: - Repository

final class Repository: RepositoryType {

    enum Error: LocalizedError {
        case client(String)
        case remote(Int)
        case unknown

        var errorDescription: String? {
            switch self {
            case let .client(reason):
                return "A client error occurred: \(reason)."
            case let .remote(statusCode):
                return "Server replied with \(statusCode) status code."
            default:
                return "An unknown error occurred"
            }
        }
    }

    lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 20
        return URLSession(configuration: configuration)
    }()

}

// MARK: - Repository + Response

extension Repository {

    func response<T>(_ request: URLRequestConvertible) -> Single<T> where T: Decodable {
        session.rx.response(request: request.toURLRequest())
            .materialize()
            .map { event -> T in
                switch event {
                case let .error(err):
                    throw Error.client(err.localizedDescription)
                case let .next((response, data)):
                    guard 200 ... 299 ~= response.statusCode else {
                        throw Error.remote(response.statusCode)
                    }
                    let decoder = JSONDecoder()
                    let object: T = try decoder.decode(T.self, from: data)
                    return object
                case .completed:
                    throw Error.unknown
                }
            }
            .take(1)
            .asSingle()
    }

}
