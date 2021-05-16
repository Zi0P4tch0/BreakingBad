import Foundation

protocol URLRequestConvertible {
    func toURLRequest() -> URLRequest
}

// MARK: - URLRequest + URLRequestConvertible

extension URLRequest: URLRequestConvertible {
    func toURLRequest() -> URLRequest {
        self
    }
}
