@testable import BreakingBad
import XCTest
import Resolver
import RxTest
import RxSwift

class FakeCharactersRepository: CharacterRepositoryType {

    @LazyInjected
    var scheduler: TestScheduler

    var allCharactersCalled = false
    var allCharactersResult: [Character] = []

    func allCharacters() -> Single<[Character]> {
        allCharactersCalled = true
        return scheduler
            .createColdObservable([.next(10, allCharactersResult), .completed(20)])
            .asSingle()
    }
}
