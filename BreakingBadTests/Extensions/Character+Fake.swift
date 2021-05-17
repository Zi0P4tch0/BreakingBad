@testable import BreakingBad
import XCTest
import RxTest

extension Character {

    static func fake(id: Int = 0, birthday: Date? = nil) -> Character {
        Character(id: id,
                  name: "Carlos Matos",
                  birthday: birthday,
                  occupation: ["Bitconnect CEO"],
                  image: URL(string: "www.google.com")!,
                  status: "At Large",
                  appearance: [],
                  nickname: "Bitconnect Guy",
                  portrayedBy: "Matos Carlos",
                  liked: true)
    }

}
