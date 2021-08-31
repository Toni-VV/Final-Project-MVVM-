import UIKit

final class EpisodeCharacterDetailVC: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: EpisodeCharacterDetailProtocol! {
        didSet {
            characterImage.fetchImage(from: viewModel.characterImage)
            characterNameLabel.text = "Name:  \(viewModel.name)"
            characterStatusLabel.text = "Status:  \(viewModel.status)"
            characterSpeciesLabel.text = "Species:  \(viewModel.species)"
            characterGenderLabel.text = "Gender:  \(viewModel.gender)"
            setupFavoriteButton()
        }
    }
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundColor()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "EpisodeCharacterDetail")
        return table
    }()
    
    private let characterNameLabel = UILabel(alignment: .left)
    private let characterStatusLabel = UILabel(alignment: .left)
    private let characterSpeciesLabel = UILabel(alignment: .left)
    private let characterGenderLabel = UILabel(alignment: .left)
    
    private let characterImage = CharacterImageView(cornerRadius: 20)
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        buttonActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTableViewConstraints()
    }
    
    //MARK: - Actions
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    private func setupTableViewConstraints() {
        let cellHeight = (view.bounds.height - characterImage.bounds.height) / 7
        tableView.rowHeight = cellHeight
        tableView.constraint(top: characterImage.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             bottom: view.bottomAnchor,
                             topConstant: 20)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor()
        [characterImage,favoriteButton].forEach(view.addSubview(_:))
        setupConstraints()
    }
    
    private func setupConstraints() {
        characterImage.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  topConstant: 20,
                                  leftConstant: 18,
                                  rightConstant: 18,
                                  heightConstant: view.bounds.height / 2.5)
        
        favoriteButton.constraint(top: characterImage.bottomAnchor,
                                  right: view.rightAnchor,
                                  topConstant: -50,
                                  rightConstant: 10,
                                  widthConstant: 50,
                                  heightConstant: 50)
    }
    
    private func buttonActions() {
        favoriteButton.addTarget(self,
                                 action: #selector(didTapFavoriteButton),
                                 for: .touchUpInside)
    }
    
    private func setupFavoriteButton() {
        setStatusForFavoriteButton(with: viewModel.isFavorite.value)
        
        viewModel.isFavorite.bind { [ unowned self ] (isFavorite) in
            setStatusForFavoriteButton(with: isFavorite)
        }
    }
    
    private func setStatusForFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .white
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.favoriteButtonPressed()
    }
}

//MARK: -Extensions

extension EpisodeCharacterDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCharacterDetail", for: indexPath)
        let labels = [characterNameLabel, characterStatusLabel, characterSpeciesLabel, characterGenderLabel]
        let text = labels[indexPath.row].text
        configureCell(cell: cell, text: text ?? "")
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, text: String) {
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textColor = UIColor.titleColor()
        cell.backgroundColor = UIColor.backgroundColor()
    }
}


