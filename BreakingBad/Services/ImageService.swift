import Foundation
import Kingfisher

// MARK: - Protocol

protocol ImageServiceType {
    func fetchImage(url: URL) -> Single<UIImage?>
}

// MARK: - Implementation

final class ImageService {

}

// MARK: - ImageService + ImageServiceType

extension ImageService: ImageServiceType {

    func fetchImage(url: URL) -> Single<UIImage?> {

        let queue = DispatchQueue.global(qos: .userInitiated)

        return Single.create { observer in

            let task =
                KingfisherManager.shared
                    .retrieveImage(with: url,
                                   options: [.callbackQueue(.dispatch(queue))],
                                   progressBlock: nil,
                                   downloadTaskUpdated: nil) { result in
                switch result {
                case .success(let imageResult):
                    observer(.success(imageResult.image))
                case .failure(let error):
                    observer(.failure(error))
                }
            }

            return Disposables.create {
                task?.cancel()
            }

        }

    }

}
