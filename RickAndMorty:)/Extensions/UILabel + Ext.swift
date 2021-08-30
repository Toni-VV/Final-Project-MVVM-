import UIKit

extension UILabel {
    
    convenience init(text: String? = nil,
                     color: UIColor,
                     font: CGFloat,
                     lines: Int,
                     weight: UIFont.Weight,
                     alignment: NSTextAlignment = .center) {
        self.init()
        self.text = text
        self.textColor = color
        let font = UIFont(name: "Copperplate-Bold", size: font)
        self.font = font
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(color: UIColor = UIColor.titleColor(),
                     font: CGFloat = 20,
                     lines: Int = 0,
                     alignment: NSTextAlignment = .left ) {
        self.init()
        self.textColor = color
        let font = UIFont(name: "Copperplate-Light", size: font)
        self.font = font
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String,
                     textColor: UIColor = UIColor.white,
                     font: CGFloat,
                     weight: UIFont.Weight = .bold) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: font,
                                      weight: weight)
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
