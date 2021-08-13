import UIKit

class MainCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "MainCell"
    
   private let mainImage = UIImageView(contentMode: .scaleAspectFill,
                                cornerRadius: 30)
    
   private let titleLabel = UILabel(color: .secondarySystemBackground,
                             font: .systemFont(ofSize: 40,
                                               weight: .semibold),
                             lines: 1,
                             alignment: .center)
    
    var viewModel: MainViewModelCellProtocol! {
        didSet {
            mainImage.image = applyFilter(intensity: 0.4,
                                          image: viewModel.image)
            titleLabel.text = viewModel.title
        }
    }
    
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
        let beginImage = CIImage(image: UIImage(named: image)!)
        let filter = CIFilter(name: "CIVignetteEffect")
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        filter?.setValue(0.4, forKey: kCIInputIntensityKey)
        let newImage = UIImage(ciImage: (filter?.outputImage)!)
        return newImage
    }
}
