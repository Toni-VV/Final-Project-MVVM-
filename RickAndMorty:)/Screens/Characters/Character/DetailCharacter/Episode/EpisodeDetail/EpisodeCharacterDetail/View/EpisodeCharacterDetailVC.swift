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
    
    private let characterImage = CharacterImageView(cornerRadius: 20)
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    
    // labels
    private let characterNameLabel = UILabel(color: .systemPurple,
                                             font: 30,
                                             lines: 1)
    private let characterStatusLabel = UILabel(color: .systemPurple,
                                               font: 30,
                                               lines: 1)
    private let characterSpeciesLabel = UILabel(color: .systemPurple,
                                                font: 30,
                                                lines: 1)
    private let characterGenderLabel = UILabel(color: .systemPurple,
                                               font: 30,
                                               lines: 1)
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        [characterImage,favoriteButton,characterNameLabel,
        characterStatusLabel,characterSpeciesLabel,
        characterGenderLabel].forEach(view.addSubview(_:))
        
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
        let heightLabel = CGFloat((view.frame.size.height - characterImage.frame.size.height) / 7)
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
        setLabelsColor()
    }
    private func setLabelsColor() {
        let labels = [characterNameLabel, characterStatusLabel,
                      characterSpeciesLabel, characterGenderLabel]
        switch favoriteButton.tintColor {
        case UIColor.red:
            labels.forEach {
                $0.textColor = .systemPink
            }
        case UIColor.white:
            labels.forEach {
                $0.textColor = .systemPurple
            }
        default:
            break
        }
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.favoriteButtonPressed()
    }
}
