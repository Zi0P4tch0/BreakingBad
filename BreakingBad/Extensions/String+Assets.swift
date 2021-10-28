import Foundation
import UIKit

private class BundleHelper {}
private let bundle = Bundle(for: BundleHelper.self)

extension String {

    func localized() -> String {
        NSLocalizedString(self,
                          tableName: nil,
                          bundle: bundle,
                          value: "**\(self)**",
                          comment: "")
    }

    func image() -> UIImage? {
        UIImage(named: self, in: bundle, with: nil)
    }

}
