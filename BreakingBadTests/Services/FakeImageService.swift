@testable import BreakingBad
import XCTest
import RxTest
import RxSwift
import Resolver

class FakeImageService: ImageServiceType {

    @LazyInjected
    private var scheduler: TestScheduler

    var fetchImageCalled = false
    var fetchImageResult: UIImage? = nil

    func fetchImage(url: URL) -> Single<UIImage?> {
        fetchImageCalled = true
        return scheduler
            .createColdObservable([.next(10, fetchImageResult), .completed(20)])
            .asSingle()
    }

}
