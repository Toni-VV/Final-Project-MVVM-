import UIKit

extension UILabel {
    
    convenience init(text: String? = nil,
                     color: UIColor,
                     font: UIFont,
                     lines: Int,
                     alignment: NSTextAlignment) {
        self.init()
        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(color: UIColor = UIColor.titleColor(),
                     font: CGFloat = 25,
                     lines: Int = 0) {
        self.init()
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: font)
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String, textColor: UIColor = UIColor.white,font: CGFloat) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: font)
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
