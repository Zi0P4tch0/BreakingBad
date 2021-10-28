@testable import BreakingBad
import XCTest
import RxTest
import RxSwift
import Resolver

final class FakeQuoteRepository: QuoteRepositoryType {

    @LazyInjected
    private var scheduler: TestScheduler

    var allQuotesCalled = false
    var allQuotesResult: [Quote] = []

    func allQuotes(for character: Character) -> Single<[Quote]> {
        allQuotesCalled = true
        return scheduler
            .createColdObservable([.next(10, allQuotesResult), .completed(20)])
            .asSingle()
    }
}
