import UIKit

final class MainCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "MainCell"
    
    var viewModel: MainViewModelCellProtocol! {
        didSet {
            mainImage.image = applyFilter(intensity: 0.4,
                                          image: viewModel.commonString)
            titleLabel.text = viewModel.commonString
        }
    }
   
    private let mainImage = UIImageView(contentMode: .scaleAspectFill,
                                        cornerRadius: 30)
    private let titleLabel = UILabel(color: .tertiarySystemBackground,
                                     font: 45, lines: 1,
                                     weight: .bold, alignment: .center)

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setupView() {
        contentView.addSubview(mainImage)
        mainImage.addSubview(titleLabel)
        contentView.backgroundColor = UIColor.backgroundColor()
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainImage.constraint(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             bottom: contentView.bottomAnchor,
                             topConstant: 10,
                             leftConstant: 20,
                             bottomConstant: 10,
                             rightConstant: 20)
        
        titleLabel.constraint(top: mainImage.topAnchor,
                              left: mainImage.leftAnchor,
                              right: mainImage.rightAnchor,
                              bottom: mainImage.bottomAnchor,
                              topConstant: 0,
                              leftConstant: 20,
                              bottomConstant: 0,
                              rightConstant: 20)
    }
    
    private func applyFilter(intensity: Float, image: String) -> UIImage {
        let filter = makeEffectFilter(intensity: intensity, image: image)
        let newImage = UIImage(ciImage: (filter?.outputImage) ?? CIImage())
        return newImage
    }
    
    private func makeEffectFilter(intensity: Float, image: String?) -> CIFilter? {
        guard
            let name = image, let startImage = CIImage(image: UIImage(named: name) ?? UIImage())
        else { return nil }
        let filter = CIFilter(name: "CIVignetteEffect")
        filter?.setValue(startImage, forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return filter
    }
}
