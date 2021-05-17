@testable import BreakingBad
import XCTest
import RxTest
import RxBlocking

extension Character {

    static func fake(id: Int = 0) -> Character {
        Character(id: id,
                  name: "Carlos Matos",
                  birthday: nil,
                  occupation: ["Bitconnect CEO"],
                  image: URL(string: "www.google.com")!,
                  status: "At Large",
                  appearance: [],
                  nickname: "Bitconnect Guy",
                  portrayedBy: "Matos Carlos",
                  liked: true)
    }

}
