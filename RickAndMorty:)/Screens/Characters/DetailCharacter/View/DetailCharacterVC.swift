import UIKit

class DetailCharacterVC: UIViewController {
    
    //MARK: - Properties
    var episodes: [String] = []
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    let descriptionLabel = UILabel(color: .white, font: 25)
    
    private let characterImage = UIImageView(contentMode: .scaleAspectFill,
                                          cornerRadius: 20)
    private let episodeButton = UIButton(text: "Episodes",
                                         color: UIColor.titleColor(),
                                         aligment: .center,
                                         borderColor: UIColor.titleColor().cgColor,
                                         font: 25,
                                         borderWidth: 1,
                                         cornerRadius: 20)
 
    var viewModel: DetailCharacterViewModelProtocol! {
        didSet {
            characterImage.image = UIImage(data: viewModel.characterImageData)
            descriptionLabel.text = viewModel.description
            episodes = viewModel.episodes
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(name: viewModel.title,
                           action: #selector(didTapBackButton))
        setupView()
        setupFavoriteButton()
        
    }
    
    //MARK: - Actions
    
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor()
        [characterImage,favoriteButton,descriptionLabel,episodeButton].forEach(view.addSubview(_:))
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
        episodeButton.constraint(left: view.leftAnchor,
                                     right: view.rightAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     leftConstant: 20,
                                     bottomConstant: 20,
                                     rightConstant: 20,
                                     heightConstant: 50)
    }
    
    private func setupFavoriteButton() {
        setStatusForFavoriteButton(with: viewModel.isFavorite.value)
        
        viewModel.isFavorite.bind { [ unowned self ] (isFavorite) in
            setStatusForFavoriteButton(with: isFavorite)
        }
        favoriteButton.addTarget(self,
                                 action: #selector(didTapFavoriteButton),
                                 for: .touchUpInside)
    }
    
    private func setStatusForFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .white
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.favoriteButtonPressed()
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

}
