import Cartography
import UIKit

// MARK: - Delegate

protocol CharacterViewControllerDelegate: AnyObject {
    func didTapReview(for character: Character)
}

// MARK: - View Controller

final class CharacterViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: Delegate

    weak var delegate: CharacterViewControllerDelegate?

    // MARK: View Model

    var viewModel: CharacterViewModelType!

    // MARK: Views

    let scrollView = UIScrollView(frame: .zero)

    lazy var imageView: UIImageView = {
        $0.backgroundColor = .gray.withAlphaComponent(0.5)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView(frame: .zero))

    lazy var nicknameLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel(frame: .zero))

    lazy var birthdayLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel(frame: .zero))

    lazy var occupationLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: .zero))

    lazy var statusLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel(frame: .zero))

    lazy var portrayedByLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel(frame: .zero))

    lazy var seasonsLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: .zero))

    lazy var quotesLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: .zero))

    lazy var likeButton: UIButton = {
        $0.setImage(R.image.like.highlighted(), for: .highlighted)
        $0.setImage(R.image.like.normal(), for: .normal)
        return $0
    }(UIButton(frame: .zero))

    let rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.review(),
                                             style: .plain,
                                             target: nil,
                                             action: nil)

    // MARK: Lifecycle

    // swiftlint:disable:next function_body_length
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view hierarchy
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nicknameLabel)
        scrollView.addSubview(birthdayLabel)
        scrollView.addSubview(occupationLabel)
        scrollView.addSubview(statusLabel)
        scrollView.addSubview(portrayedByLabel)
        scrollView.addSubview(seasonsLabel)
        scrollView.addSubview(quotesLabel)
        scrollView.addSubview(likeButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        // Constraints
        constrain(view, scrollView, imageView) { view, scrollView, imageView in
            scrollView.edges == view.edges
            imageView.top == scrollView.top + 20
            imageView.centerX == scrollView.centerX
            imageView.width == scrollView.width * 0.8
            imageView.height == scrollView.width * 0.8
        }
        constrain(nicknameLabel, imageView) { nicknameLabel, imageView in
            nicknameLabel.centerX == imageView.centerX
            nicknameLabel.top == imageView.bottom + 8
        }
        constrain(birthdayLabel, nicknameLabel) { birthdayLabel, nicknameLabel in
            birthdayLabel.centerX == nicknameLabel.centerX
            birthdayLabel.top == nicknameLabel.bottom + 8
        }
        constrain(occupationLabel, birthdayLabel) { occupationLabel, birthdayLabel in
            occupationLabel.centerX == birthdayLabel.centerX
            occupationLabel.top == birthdayLabel.bottom + 8
        }
        constrain(statusLabel, occupationLabel) { statusLabel, occupationLabel in
            statusLabel.centerX == occupationLabel.centerX
            statusLabel.top == occupationLabel.bottom + 8
        }
        constrain(portrayedByLabel, statusLabel) { portrayedByLabel, statusLabel in
            portrayedByLabel.centerX == statusLabel.centerX
            portrayedByLabel.top == statusLabel.bottom + 8
        }
        constrain(seasonsLabel, portrayedByLabel) { seasonsLabel, portrayedByLabel in
            seasonsLabel.centerX == portrayedByLabel.centerX
            seasonsLabel.top == portrayedByLabel.bottom + 8
        }
        constrain(quotesLabel, seasonsLabel, scrollView) { quotesLabel, seasonsLabel, scrollView in
            quotesLabel.top == seasonsLabel.bottom + 16
            quotesLabel.centerX == scrollView.centerX
            quotesLabel.width == scrollView.width * 0.8
            quotesLabel.bottom == scrollView.bottom - 16
        }
        constrain(likeButton, imageView) { likeButton, imageView in
            likeButton.right == imageView.right - 16
            likeButton.bottom == imageView.bottom - 16
        }
        // Rx bindings
        bind(viewModel.outputs)
        bind(viewModel.inputs)
        // Trigger "viewDidLoad" view model input
        viewModel.inputs.viewDidLoad.onNext(())
    }

}

// MARK: - CharacterViewController + Rx

extension CharacterViewController {

    func bind(_ outputs: CharacterViewModelOutputs) {

        outputs.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        outputs.image
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)

        outputs.birthday
            .drive(birthdayLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.occupation
            .drive(occupationLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.status
            .drive(statusLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.nickname
            .drive(nicknameLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.portrayedBy
            .drive(portrayedByLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.seasons
            .drive(seasonsLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.quotes
            .drive(quotesLabel.rx.attributedText)
            .disposed(by: disposeBag)

        outputs.likeButtonHighlighted
            .drive(likeButton.rx.isHighlighted)
            .disposed(by: disposeBag)

        outputs.presentReview
            .drive(onNext: { [weak self] character in
                guard let self = self else { return }
                self.delegate?.didTapReview(for: character)
            })
            .disposed(by: disposeBag)

        outputs.isImageLoading
            .drive(imageView.rx.isLoading)
            .disposed(by: disposeBag)
    }

    func bind(_ inputs: CharacterViewModelInputs) {

        likeButton.rx.pulseTap
            .bind(to: inputs.likeButtonTapped)
            .disposed(by: disposeBag)

        rightBarButtonItem.rx.tap
            .bind(to: inputs.reviewTapped)
            .disposed(by: disposeBag)

    }

}
