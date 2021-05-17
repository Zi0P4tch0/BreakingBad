@testable import BreakingBad
import XCTest
import RxTest
import RxBlocking

class FakeCharactersRepository: CharacterRepositoryType {

    let scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    var allCharactersCalled = false
    var allCharactersResult: [Character] = []

    func allCharacters() -> Single<[Character]> {
        allCharactersCalled = true
        return scheduler
            .createColdObservable([.next(10, allCharactersResult), .completed(20)])
            .asSingle()
    }
}
