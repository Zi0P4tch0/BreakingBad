import Eureka
import UIKit

final class ReviewViewController: FormViewController {

    enum Tag: String {
        case name
        case date
        case review
        case rating
        case submit
    }

    private let disposeBag = DisposeBag()

    // MARK: - View Model

    var viewModel: ReviewViewModelType!

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        let nameRow = TextRow(Tag.name.rawValue) {
            $0.title = R.string.localizable.reviewYourName()
            $0.add(rule: RuleRequired())
        }

        let dateRow = DateInlineRow(Tag.date.rawValue) {
            $0.title = R.string.localizable.reviewWatchedDate()
            $0.value = Date()
            $0.add(rule: RuleRequired())
        }

        let reviewRow = TextAreaRow(Tag.review.rawValue) {
            $0.placeholder = R.string.localizable.reviewPlaceholder()
            $0.add(rule: RuleRequired())
        }

        let ratingRow = PickerInlineRow<Int>(Tag.rating.rawValue) {
            $0.title = R.string.localizable.reviewRating()
            $0.options = Array(1...10)
            $0.add(rule: RuleRequired())
        }

        let buttonRow = ButtonRow(Tag.submit.rawValue) {
            $0.title = R.string.localizable.reviewSubmit()
        }.onCellSelection { [weak self] _, _ in
            guard let self = self else { return }
            let validationErrors = self.form.validate()
            if validationErrors.isEmpty {
                self.viewModel.inputs.submit.onNext(
                    // swiftlint:disable force_unwrapping
                    Review(name: nameRow.value!,
                           watched: dateRow.value!,
                           text: reviewRow.value!,
                           rating: ratingRow.value!)
                    // swiftlint:enable force_unwrapping
                )
            } else {
                self.viewModel.inputs.formErrors.onNext(validationErrors)
            }
        }

        // Assemble the form
        form
            +++ nameRow
            +++ dateRow
            +++ reviewRow
            +++ ratingRow
            +++ buttonRow

        // Rx bindings
        bind(viewModel.outputs)

    }

}

// MARK: - Rx Bindings

extension ReviewViewController {

    func bind(_ outputs: ReviewViewModelOutputs) {

        outputs.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        outputs.alert
            .drive(rx.alert)
            .disposed(by: disposeBag)

    }

}
