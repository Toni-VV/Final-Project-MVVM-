import UIKit

extension UIButton {
    
    convenience init(systemName: String = "circle.fill",
                     tintColor: UIColor,
                     tag: Int = 0,
                     isSetUpImage: Bool = true) {
        self.init()
        self.tag = tag
        if isSetUpImage {
            let image = UIImage(systemName: systemName)
            self.setImage(image, for: .normal)
        }
        self.setBackgroundImage(UIImage(systemName: systemName), for: .normal)
        self.contentMode = .scaleAspectFit
        self.tintColor = tintColor
        self.clipsToBounds = true
    }
    
    convenience init(text: String,
                     color: UIColor = UIColor.titleColor(),
                     aligment: UIControl.ContentHorizontalAlignment = .center,
                     borderColor: CGColor = UIColor.titleColor().cgColor,
                     font: CGFloat,
                     borderWidth: CGFloat = 1,
                     cornerRadius: CGFloat) {
        self.init()
        self.setTitleColor(color, for: .normal)
        self.setTitle(text,for: .normal)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.titleLabel?.font = .systemFont(ofSize: font,
                                            weight: .regular)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    convenience init(textColor: UIColor = .systemRed, text: String = "Reset", alpha: CGFloat = 0.3) {
        self.init()
        self.backgroundColor = .clear
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(text ,for: .normal)
        self.alpha = alpha
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
