import UIKit

extension UIView {

    func pulse(scale: CGPoint = CGPoint(x: 1.5, y: 1.5),
               duration: TimeInterval = 0.35,
               completion: (() -> Void)? = nil) {

        guard let viewSnapshot = self.snapshotView(afterScreenUpdates: false),
              let superview = self.superview else { return }

        superview.addSubview(viewSnapshot)

        viewSnapshot.center = self.center
        viewSnapshot.alpha = 0.5

        UIView.animate(withDuration: duration, animations: {

            viewSnapshot.transform = CGAffineTransform(scaleX: scale.x, y: scale.y)
            viewSnapshot.alpha = 0

        }, completion: { _ -> Void in

            viewSnapshot.removeFromSuperview()

            completion?()

        })

    }
}

extension Reactive where Base: UIButton {

    var pulseTap: ControlEvent<Void> {
        let observable = controlEvent(.touchUpInside)
            .do(onNext: { [weak base] _ in
            base?.pulse()
        }).map { _ in () }
        return ControlEvent(events: observable)
    }

}
