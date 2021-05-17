import UIKit

final class CharactersDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {

    private(set) var viewModels: [Character] = []

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = viewModels[indexPath.row].liked ?
            "❤️ \(viewModels[indexPath.row].name)" :
            viewModels[indexPath.row].name
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<[Character]>) {

        Binder(self) { dataSource, newElements in
            dataSource.viewModels = newElements
            tableView.reloadData()
        }.on(observedEvent)

    }

}
