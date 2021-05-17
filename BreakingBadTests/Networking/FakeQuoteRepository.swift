@testable import BreakingBad
import XCTest
import RxTest

class FakeQuoteRepository: QuoteRepositoryType {

    let scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    var allQuotesCalled = false
    var allQuotesResult: [Quote] = []

    func allQuotes(for character: Character) -> Single<[Quote]> {
        allQuotesCalled = true
        return scheduler
            .createColdObservable([.next(10, allQuotesResult), .completed(20)])
            .asSingle()
    }
}
