import UIKit

final class EpisodesViewController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: EpisodeCharacterViewModelProtocol!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundColor()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")
        return table
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupTableView()
        setupNavigationBar(name: "Episodes",
                           backButton: true,
                           backAction: #selector(didTapBackButton))
    }
    
    //MARK: - Actions
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.backgroundColor()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }

    private func setupConstraints() {
        tableView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             bottom: view.bottomAnchor,
                             topConstant: 20)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions

extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let urlString = viewModel.episodeUrl(index: indexPath.row)
        viewModel.fetchData(urlString: urlString) { [weak self] (episode) in
            let text = "\(indexPath.row + 1).)   \(episode.name)"
            self?.configureCell(cell: cell, text: text)
            self?.viewModel.episodes.append(episode)
        }
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, text: String) {
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .systemTeal
        cell.textLabel?.font = UIFont(name: "Copperplate-Bold", size: 20)
//        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.backgroundColor()
    }
}


