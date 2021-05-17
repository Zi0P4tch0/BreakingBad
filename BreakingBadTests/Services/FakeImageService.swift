@testable import BreakingBad
import XCTest
import RxTest

class FakeImageService: ImageServiceType {

    let scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    var fetchImageCalled = false
    var fetchImageResult: UIImage? = nil

    func fetchImage(url: URL) -> Single<UIImage?> {
        fetchImageCalled = true
        return scheduler
            .createColdObservable([.next(10, fetchImageResult), .completed(20)])
            .asSingle()
    }

}
