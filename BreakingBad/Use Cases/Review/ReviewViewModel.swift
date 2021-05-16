import Eureka
import RxCocoa
import RxSwift

protocol ReviewViewModelOutputs {
    var title: Driver<String> { get }
    var alert: Driver<AlertViewModel> { get }
}

protocol ReviewViewModelInputs {
    var formErrors: PublishSubject<[ValidationError]> { get }
    var submit: PublishSubject<Review> { get }
}

protocol ReviewViewModelType {
    var outputs: ReviewViewModelOutputs { get }
    var inputs: ReviewViewModelInputs { get }
}

struct Review: Encodable {
    let name: String
    let watched: Date
    let text: String
    let rating: Int
}

final class ReviewViewModel: ReviewViewModelType,
                             ReviewViewModelOutputs,
                             ReviewViewModelInputs {

    var outputs: ReviewViewModelOutputs { self }
    var inputs: ReviewViewModelInputs { self }

    // MARK: - Inputs

    let title: Driver<String>
    let alert: Driver<AlertViewModel>

    // MARK: - Outputs

    let formErrors = PublishSubject<[ValidationError]>()
    let submit = PublishSubject<Review>()

    init(character: Character, reviewRepository: ReviewRepositoryType) {

        title = .just(R.string.localizable.reviewTitle())

        let submit = submit.flatMap {
            reviewRepository.review(character: character, with: $0).asObservable().materialize()
        }

        // Show an alert if there's a validation error or a network one.
        alert = Observable.merge(
            formErrors.filter { !$0.isEmpty }.map { _ in
                AlertViewModel(title: R.string.localizable.genericError(),
                               message: R.string.localizable.reviewErrorMissingFields())
            },
            submit.compactMap { $0.error }.map {
                AlertViewModel(title: R.string.localizable.genericError(),
                               message: $0.localizedDescription)
            }
        )
        .asDriver(onErrorJustReturn: .empty)

    }

}
