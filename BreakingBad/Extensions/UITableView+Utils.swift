import UIKit

extension UITableView {

    func registerCell<T>(_ class: T.Type) where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }

}
