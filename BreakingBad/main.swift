import RxSwift
import UIKit

#if DEBUG
// Monitor RxSwift resources 
_ = Observable<Int>.interval(.milliseconds(350), scheduler: MainScheduler.instance)
        .map { _ in RxSwift.Resources.total }
        .distinctUntilChanged()
        .subscribe(onNext: { resources in
            print("⚠️ RxSwift Resources: \(resources)")
        })
#endif

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(UIApplication.self),
    NSStringFromClass(AppDelegate.self)
)
