import UIKit

struct AlertViewModel {

    static let empty = AlertViewModel(title: "", message: "")

    let title: String
    let message: String
}

extension Reactive where Base: UIViewController {

    var alert: Binder<AlertViewModel> {
        Binder(base) { target, value in
            let alertViewController = UIAlertController(title: value.title,
                                                        message: value.message,
                                                        preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: R.string.localizable.genericOk(),
                                                        style: .default,
                                                        handler: nil))
            target.present(alertViewController, animated: true)
        }
    }

}
