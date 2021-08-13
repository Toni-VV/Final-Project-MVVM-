import UIKit

extension UIView{
    
     func constraint(top: NSLayoutYAxisAnchor? = nil,
                     left: NSLayoutXAxisAnchor? = nil,
                            right: NSLayoutXAxisAnchor? = nil,
                            bottom: NSLayoutYAxisAnchor? = nil,
                            topConstant: CGFloat = 0,
                            leftConstant: CGFloat = 0,
                            bottomConstant: CGFloat = 0,
                            rightConstant: CGFloat = 0,
                            widthConstant: CGFloat = 0,
                            heightConstant: CGFloat = 0){
        
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        if let top = top{
            constraints.append(topAnchor.constraint(equalTo: top,
                                                    constant: topConstant))
        }
        if let left = left{
            constraints.append(leftAnchor.constraint(equalTo: left,
                                                     constant: leftConstant))
        }
        if let right = right{
            constraints.append(rightAnchor.constraint(equalTo: right,
                                                      constant: -rightConstant))
        }
        if let bottom = bottom{
            constraints.append(bottomAnchor.constraint(equalTo: bottom,
                                                       constant: -bottomConstant))
        }
        
        if widthConstant > 0{
            constraints.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0{
            constraints.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        constraints.forEach({$0.isActive = true})
    }
}
