import Foundation

extension KeyedDecodingContainer {

    func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        try self.decode(T.self, forKey: key)
    }

    func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
        try self.decodeIfPresent(T.self, forKey: key)
    }

}
