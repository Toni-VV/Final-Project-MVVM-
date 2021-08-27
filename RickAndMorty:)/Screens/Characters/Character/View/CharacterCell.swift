import UIKit

final class CharacterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CharacterCell"
    
    var viewModel: CharacterViewModelCellProtocol! {
        didSet {
            characterImage.fetchImage(from: viewModel.image)
            nameLabel.text = viewModel.name
        }
    }
    
    private let characterImage = CharacterImageView(cornerRadius: 20)
    private let nameLabel = UILabel(color: .black,
                                    font: 20, lines: 1,
                                    weight: .regular,
                                    alignment: .center)
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let v = UIBlurEffect(style: .light)
        let blurEffect = UIVisualEffectView(effect: v)
        return blurEffect
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    override func prepareForReuse() {
        characterImage.image = nil
        nameLabel.text = nil
    }
    
    private func setupView() {
        [characterImage, blurEffectView, nameLabel].forEach(addSubview(_:))
        setupConstraints()
    }
    
    private func setupConstraints() {
        characterImage.constraint(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  bottom: contentView.bottomAnchor)
        
        blurEffectView.constraint(left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  bottom: contentView.bottomAnchor,
                                  heightConstant: 30)
        
        nameLabel.constraint(left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             bottom: contentView.bottomAnchor,
                             heightConstant: 30)
    }
}
