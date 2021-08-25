import UIKit

final class EpisodeDetailVC : UIViewController {
    
    //MARK: - Properties
    
    var viewModel: EpisodeDetailViewModelProtocol! {
        didSet {
            title = viewModel.description
            descriptionLabel.text = viewModel.description
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundColor()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell2")
        return table
    }()
    private let descriptionLabel = UILabel(color: .systemTeal,
                                           font: 25,
                                           lines: 0,
                                           weight: .semibold,
                                           alignment: .left)
    private let episodeCharacterButton = UIButton(text: "Characters in episode",
                                                  font: 25,
                                                  cornerRadius: 20)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupTableView()
        setCharacters()
        episodeCharacterButton.addTarget(self,
                                         action: #selector(didTapEpisodeCharacterButton),
                                         for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.isHidden = true
        tableView.backgroundColor = UIColor.backgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.frame.size.height / 5
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(descriptionLabel)
        view.addSubview(episodeCharacterButton)
        let height = view.bounds.height / 10
        
        descriptionLabel.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    topConstant: 20,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: height)
        episodeCharacterButton.constraint(top: descriptionLabel.bottomAnchor,
                                          left: view.leftAnchor,
                                          right: view.rightAnchor,
                                          topConstant: 18,
                                          leftConstant: 18,
                                          rightConstant: 18,
                                          heightConstant: height)
        
        tableView.constraint(top: episodeCharacterButton.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             bottom: view.bottomAnchor,
                             topConstant: 18)
    }
    
    private func setCharacters() {
        viewModel.setCharacters()
    }
    
    @objc private func didTapEpisodeCharacterButton() {
            self.tableView.isHidden = false
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions

extension EpisodeDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2",
                                                 for: indexPath)
        let urlString = viewModel.characterUrlStrings[indexPath.row]
        viewModel.fetchData(urlString: urlString) { [weak self] (character) in
            DispatchQueue.main.async {
                self?.configure(cell: cell, character: character)
            }
        }
        return cell
    }
    
    
    
    private func configure(cell: UITableViewCell, character: Character) {
        cell.textLabel?.text = character.name
        cell.textLabel?.textColor = UIColor.titleColor()
        cell.backgroundColor = UIColor.backgroundColor()
        let url = URL(string: character.image)
        guard
            let imageData = ImageManager.shared.fetchImage(url: url)
        else { return }
        cell.imageView?.image = UIImage(data: imageData)
        cell.imageView?.layer.cornerRadius = cell.bounds.height / 2
    }
    
}

