import Cartography
import UIKit

protocol CharactersViewControllerDelegate: AnyObject {
    func didSelect(character: Character)
}

final class CharactersViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: - Delegate

    weak var delegate: CharactersViewControllerDelegate?

    // MARK: - View Model

    var viewModel: CharactersViewModelType!

    // MARK: - Data Source

    let dataSource = CharactersDataSource()

    // MARK: - Views

    lazy var tableView: UITableView = {
        $0.registerCell(UITableViewCell.self)
        return $0
    }(UITableView(frame: .zero))

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        constrain(view, tableView) { view, tableView in
            tableView.edges == view.edges
        }
        bind(viewModel.outputs)
        bind(viewModel.inputs)
        viewModel.inputs.viewDidLoad.onNext(())
    }

}

// MARK: - CharactersViewController + Rx Bindings

extension CharactersViewController {

    func bind(_ outputs: CharactersViewModelOutputs) {

        outputs.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        outputs.characters
            .drive(tableView.rx.items(dataSource: dataSource))
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
