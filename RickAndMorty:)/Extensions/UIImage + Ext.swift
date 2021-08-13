import UIKit

extension UIImageView {
    
    convenience init(contentMode: UIView.ContentMode,
                     cornerRadius: CGFloat) {
        self.init()
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
