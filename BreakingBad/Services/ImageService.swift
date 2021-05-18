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

        Single.create { observer in

            let task =
                KingfisherManager.shared
                    .retrieveImage(with: url,
                                   options: [.callbackQueue(.mainAsync)],
                                   progressBlock: nil,
                                   downloadTaskUpdated: nil) { result in
                switch result {
                case .success(let imageResult):
                    DispatchQueue.main.async {
                        observer(.success(imageResult.image))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        observer(.failure(error))
                    }
                }
            }

            return Disposables.create {
                task?.cancel()
            }

        }

    }

}
