import Cartography
import RxSwift
import UIKit

// MARK: - Delegate

protocol CharactersViewControllerDelegate: AnyObject {
    func didSelect(character: Character)
}

// MARK: - View Controller

final class CharactersViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: Delegate

    weak var delegate: CharactersViewControllerDelegate?

    // MARK: View Model

    var viewModel: CharactersViewModelType!

    // MARK: Data Source

    let dataSource = CharactersDataSource()

    // MARK: Views

    lazy var emptyLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel(frame: .zero))

    lazy var tableView: UITableView = {
        $0.registerCell(UITableViewCell.self)
        return $0
    }(UITableView(frame: .zero))

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the view hierarchy
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
        constrain(view, tableView, emptyLabel) { view, tableView, emptyLabel in
            tableView.edges == view.edges
            emptyLabel.center == view.center
        }
        // Rx bindings
        bind(viewModel.outputs)
        bind(viewModel.inputs)
        // Trigger "viewDidLoad" view model input
        viewModel.inputs.viewDidLoad.onNext(())
    }

}

// MARK: - CharactersViewController + Rx

extension CharactersViewController {

    func bind(_ outputs: CharactersViewModelOutputs) {

        outputs.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        outputs.characters
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        outputs.emptyText
            .drive(emptyLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.tableViewAlpha
            .drive(tableView.rx.alpha)
            .disposed(by: disposeBag)

    }

    func bind(_ inputs: CharactersViewModelInputs) {

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let character = self.dataSource.viewModels[indexPath.row]
            self.delegate?.didSelect(character: character)
        }).disposed(by: disposeBag)

    }

}
