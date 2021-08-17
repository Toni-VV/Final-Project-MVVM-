import UIKit

final class DetailCharacterVC: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: DetailCharacterViewModelProtocol! {
        didSet {
            title = viewModel.title
            characterImage.image = UIImage(data: viewModel.characterImageData)
            descriptionLabel.text = viewModel.description
        }
    }
    private let nextButton = UIButton(systemName: "chevron.right.2",
                                      tintColor: UIColor.titleColor())
    private let previousButton = UIButton(systemName: "chevron.left.2",
                                          tintColor: UIColor.titleColor())

    private let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "suit.heart.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleToFill
        return button
    }()
    private let descriptionLabel = UILabel(color: .white, font: 25)
    private let characterImage = UIImageView(contentMode: .scaleAspectFill,
                                          cornerRadius: 20)

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(name: title ?? "",
                           action: #selector(didTapBackButton))
        setupView()
        setupFavoriteButton()
        buttonActions()
    }
    
    //MARK: - Actions
    
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor()
        [characterImage,favoriteButton,
         descriptionLabel, nextButton, previousButton].forEach(view.addSubview(_:))
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
                                    bottom: nextButton.topAnchor,
                                    topConstant: 20,
                                    leftConstant: 20, bottomConstant: 20,
                                    rightConstant: 20)
        
        let widthSize = view.frame.size.width / 4
        let height = view.frame.size.height / 10
        nextButton.constraint(right: view.rightAnchor,
                              bottom: view.bottomAnchor,
                              bottomConstant: 20,
                              widthConstant: widthSize,
                              heightConstant: height)
        previousButton.constraint(left: view.leftAnchor,
                                  bottom: view.bottomAnchor,
                                  bottomConstant: 20,
                                  widthConstant: widthSize,
                                  heightConstant: height )
    }
    
    private func buttonActions() {
        nextButton.addTarget(self,
                             action: #selector(didTapNextButton),
                             for: .touchUpInside)
        previousButton.addTarget(self,
                                 action: #selector(didTapPreviousButton),
                                 for: .touchUpInside)
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
