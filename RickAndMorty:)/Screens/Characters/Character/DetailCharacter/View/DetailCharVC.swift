import UIKit

final class DetailCharacterVC: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: DetailCharacterViewModelProtocol! {
        didSet {
            characterImage.fetchImage(from: viewModel.characterImage )
            characterNameLabel.text = "Name:  \(viewModel.name)"
            characterStatusLabel.text = "Status:  \(viewModel.status)"
            characterSpeciesLabel.text = "Species:  \(viewModel.species)"
            characterGenderLabel.text = "Gender:  \(viewModel.gender)"
            charactersCountLabel.text = "\(viewModel.index + 1) of \(viewModel.characters.count)"
            title = viewModel.title
            setupFavoriteButton()
        }
    }
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    private let nextButton = UIButton(systemName: "chevron.right.2",
                                      tintColor: UIColor.titleColor(),
                                      isSetUpImage: false)
    private let previousButton = UIButton(systemName: "chevron.left.2",
                                          tintColor: UIColor.titleColor(),
                                          isSetUpImage: false)
    private let charactersCountLabel = UILabel(color: UIColor.titleColor(),
                                               font: 25,
                                               lines: 1,
                                               weight: .regular)
    private let characterNameLabel = UILabel(color: .white,
                                             font: 30,
                                             lines: 1)
    private let characterStatusLabel = UILabel(color: .white,
                                               font: 30,
                                               lines: 1)
    private let characterSpeciesLabel = UILabel(color: .white,
                                                font: 30,
                                                lines: 1)
    private let characterGenderLabel = UILabel(color: .white,
                                               font: 30,
                                               lines: 1)
    private let characterImage = CharacterImageView(cornerRadius: 20)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(name: viewModel.title,
                           backButton: true,
                           forwardButton: true,
                           backAction: #selector(didTapBackButton),
                           forwardAction: #selector(didTapEpisodesButton))
        setupView()
        buttonActions()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Actions
    
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor()
        [characterImage,favoriteButton,
         characterNameLabel,characterStatusLabel,
         characterSpeciesLabel,characterGenderLabel,nextButton,
         previousButton,charactersCountLabel].forEach(view.addSubview(_:))
        
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
        // labels
        let heightLabel = CGFloat((view.frame.size.height - characterImage.frame.size.height - nextButton.frame.size.height) / 7)
        characterNameLabel.constraint(top: characterImage.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    topConstant: 20,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: heightLabel)
        characterStatusLabel.constraint(top: characterNameLabel.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: heightLabel)
        characterSpeciesLabel.constraint(top: characterStatusLabel.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: heightLabel)
        characterGenderLabel.constraint(top: characterSpeciesLabel.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: heightLabel)
        
        
        // buttons
        let widthButton = view.frame.size.width / 4
        let heightButton = view.frame.size.height / 10
        nextButton.constraint(right: view.rightAnchor,
                              bottom: view.bottomAnchor,
                              bottomConstant: 20,
                              widthConstant: widthButton,
                              heightConstant: heightButton)
        previousButton.constraint(left: view.leftAnchor,
                                  bottom: view.bottomAnchor,
                                  bottomConstant: 20,
                                  widthConstant: heightButton,
                                  heightConstant: heightButton )
        charactersCountLabel.constraint(left: previousButton.rightAnchor,
                                        right: nextButton.leftAnchor,
                                        bottom: view.bottomAnchor,
                                        leftConstant: 8,
                                        bottomConstant: 20,
                                        rightConstant: 8,
                                        heightConstant: heightButton)
    }
    
    private func buttonActions() {
        nextButton.addTarget(self,
                             action: #selector(didTapNextButton),
                             for: .touchUpInside)
        previousButton.addTarget(self,
                                 action: #selector(didTapPreviousButton),
                                 for: .touchUpInside)
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
        setDescriptionLabelColor()
    }
    
    private func setDescriptionLabelColor() {
        let labels = [characterNameLabel, characterStatusLabel,
                      characterSpeciesLabel, characterGenderLabel]
        switch favoriteButton.tintColor {
        case UIColor.red:
            labels.forEach {
                $0.textColor = .systemPink
            }
        case UIColor.white:
            labels.forEach {
                $0.textColor = .white
            }
        default:
            break
        }
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.favoriteButtonPressed()
    }
    
    @objc private func didTapEpisodesButton() {
        let vc = EpisodesViewController()
        vc.viewModel = viewModel.episodesViewModel(index: viewModel.index)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapNextButton() {
        if viewModel.index < viewModel.characters.count - 1 {
            viewModel = DetailCharacterViewModel(characters: viewModel.characters,
                                                 index: viewModel.index + 1)
        }
    }
    
    @objc private func didTapPreviousButton() {
        if viewModel.index > 0 {
            viewModel = DetailCharacterViewModel(characters: viewModel.characters,
                                                 index: viewModel.index - 1)
        }
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
