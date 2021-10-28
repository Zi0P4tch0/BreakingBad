import RxCocoa
import RxSwift
import UIKit

struct AlertViewModel {

    let title: String
    let message: String
}

extension Reactive where Base: UIViewController {

    var alert: Binder<AlertViewModel?> {
        Binder(base) { target, value in
            guard let value = value else { return }
            let alertViewController = UIAlertController(title: value.title,
                                                        message: value.message,
                                                        preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "generic.ok".localized(),
                                                        style: .default,
                                                        handler: nil))
            target.present(alertViewController, animated: true)
        }
    }

}
