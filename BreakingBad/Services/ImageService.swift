import Foundation
import Kingfisher
import RxSwift
import UIKit

// MARK: - Protocol

protocol ImageServiceType {
    func fetchImage(url: URL) -> Single<UIImage?>
}

// MARK: - Concrete Class

final class ImageService { }

// MARK: - ImageServiceType

extension ImageService: ImageServiceType {

    func fetchImage(url: URL) -> Single<UIImage?> {

        Single.create { single in

            let task =
                KingfisherManager.shared
                    .retrieveImage(with: url,
                                   options: [.callbackQueue(.mainAsync)]) { result in
                switch result {
                case .success(let imageResult):
                    return single(.success(imageResult.image))

                case .failure(let error):
                    return single(.failure(error))
                }
            }

            return Disposables.create {
                task?.cancel()
            }

        }

    }

}
