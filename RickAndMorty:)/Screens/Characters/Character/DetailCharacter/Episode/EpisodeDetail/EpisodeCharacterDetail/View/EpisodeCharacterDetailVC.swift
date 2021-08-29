import UIKit

final class EpisodeCharacterDetailVC: UIViewController {
    
    var viewModel: EpisodeCharacterDetailProtocol! {
        didSet {
            characterImage.fetchImage(from: viewModel.characterImage)
            descriptionLabel.text = viewModel.description
            title = viewModel.title
            setupFavoriteButton()
        }
    }
    
    private let characterImage = CharacterImageView()
    private let descriptionLabel = UILabel(color: .white,
                                           font: 35,
                                           alignment: .center)
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar(name: viewModel.title)
        buttonActions()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor()
        [characterImage,descriptionLabel,favoriteButton].forEach(view.addSubview(_:))
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
        
        descriptionLabel.constraint(top: characterImage.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    topConstant: 20,
                                    leftConstant: 20,
                                    rightConstant: 20)
        
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
        setDescriptionLabelColor()
    }
    
    private func setDescriptionLabelColor() {
        switch favoriteButton.tintColor {
        case UIColor.red:
            descriptionLabel.textColor = .systemPink
        case UIColor.white:
            descriptionLabel.textColor = .white
        default:
            break
        }
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.favoriteButtonPressed()
    }
}
