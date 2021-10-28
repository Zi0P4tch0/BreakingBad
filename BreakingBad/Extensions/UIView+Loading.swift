import Cartography
import RxCocoa
import RxSwift
import UIKit

private let activityIndicatorTag = 0xC0FFEE

extension Reactive where Base: UIView {

    var isLoading: Binder<Bool> {
        Binder(base) { target, value in
            target.viewWithTag(activityIndicatorTag)?.removeFromSuperview()
            guard value else {
                return
            }
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.tag = activityIndicatorTag
            indicator.color = .systemBlue
            target.addSubview(indicator)
            constrain(indicator, target) { indicator, target in
                indicator.center == target.center
            }
            indicator.startAnimating()
        }
    }

}
