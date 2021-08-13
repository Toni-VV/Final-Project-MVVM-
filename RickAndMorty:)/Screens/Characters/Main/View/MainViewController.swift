import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
  private var viewModel: MainViewModelProtocol = MainViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundColor()
        table.register(MainCell.self,
                       forCellReuseIdentifier: MainCell.identifier)
        return table
    }()

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupTableView()
        setupNavigationBar(name: "Choose Section",
                           backButton: false)
    }
    
    //MARK: - Actions
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        let size = view.safeAreaInsets.top + view.safeAreaInsets.bottom
        tableView.rowHeight = (view.bounds.height - size) / 3
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier,
                                                 for: indexPath) as! MainCell
        cell.viewModel = viewModel.viewModelCell(index: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            let vc = CharacterViewController()
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}
