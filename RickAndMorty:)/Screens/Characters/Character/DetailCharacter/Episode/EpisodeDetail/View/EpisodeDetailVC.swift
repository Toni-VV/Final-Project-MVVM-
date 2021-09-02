import UIKit

final class EpisodeDetailVC : UIViewController {
    
    //MARK: - Properties
    
    var viewModel: EpisodeDetailViewModelProtocol! {
        didSet {
            title = viewModel.description
            descriptionLabel.text = viewModel.description
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let cellsPerLine = CGFloat(2)
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        let cellSize = (view.bounds.width - (spacing * 3)) / cellsPerLine
        layout.itemSize = CGSize(width: cellSize,
                                 height: cellSize)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(EpisodeDetailCell.self,
                                forCellWithReuseIdentifier: EpisodeDetailCell.identifier)
        return collectionView
    }()
    private let pleaseTapButton = UILabel(text: "Please tap button for open characters...",
                                          color: .white,
                                          font: 30,
                                          lines: 1,
                                          weight: .regular)
    private let descriptionLabel = UILabel(color: .systemPurple,
                                           font: 25,
                                           lines: 0,
                                           weight: .semibold,
                                           alignment: .center)
    private let episodeCharacterButton = UIButton(text: "Characters in episode",
                                                  font: 25,
                                                  cornerRadius: 20)
    //    private let tapOnButtonLabel = UILabel
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupCollectionView()
        setCharacters()
        setupView()
        setupConstraints()
        buttonActions()
       
    }
    
    //MARK: - Actions
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.isHidden = true
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(episodeCharacterButton)
        view.addSubview(pleaseTapButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
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
        
        pleaseTapButton.constraint(top: episodeCharacterButton.bottomAnchor,
                                   left: view.leftAnchor,
                                   right: view.rightAnchor,
                                   leftConstant: 20,
                                   rightConstant: 20,
                                   heightConstant: view.bounds.height / 9)
        
        collectionView.constraint(top: episodeCharacterButton.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  bottom: view.bottomAnchor,
                                  topConstant: 18)
    }
    
    private func buttonActions() {
        episodeCharacterButton.addTarget(self,
                                         action: #selector(didTapEpisodeCharacterButton),
                                         for: .touchUpInside)
    }
    
    private func setCharacters() {
        viewModel.setCharacters()
    }
    
    @objc private func didTapEpisodeCharacterButton() {
        self.collectionView.isHidden = !collectionView.isHidden
        self.pleaseTapButton.isHidden = !pleaseTapButton.isHidden
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionView Extensions

extension EpisodeDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailCell.identifier,
                                                      for: indexPath) as! EpisodeDetailCell
        let characterUrlString = viewModel.characterUrlStrings[indexPath.row]
        
        viewModel.fetchData(urlString: characterUrlString) { (character) in
            cell.viewModel = EpisodeDetailCellViewModel(character: character)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = EpisodeCharacterDetailVC()
        vc.viewModel = viewModel.detailEpisodeCharacter(index: indexPath)
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
    
    
}
