import Cartography
import UIKit

extension Reactive where Base: UIView {

    var isLoading: Binder<Bool> {
        Binder(base) { target, value in
            target.viewWithTag(0xC0FFEE)?.removeFromSuperview()
            guard value else {
                return
            }
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.tag = 0xC0FFEE
            indicator.color = .systemBlue
            target.addSubview(indicator)
            constrain(indicator, target) { indicator, target in
                indicator.center == target.center
            }
            indicator.startAnimating()
        }
    }

}
