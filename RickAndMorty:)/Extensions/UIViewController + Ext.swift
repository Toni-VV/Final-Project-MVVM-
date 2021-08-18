import UIKit

//MARK: - Navigation bar
extension UIViewController {
    
    func setupNavigationBar(name: String,
                            backgroundColor: UIColor = UIColor.clear,
                            titleColor: UIColor = UIColor.titleColor(),
                            largeTitleColor: UIColor = UIColor.titleColor(),
                            backButton: Bool = true,
                            forwardButton: Bool = false,
                            backAction: Selector? = nil,
                            forwardAction: Selector? = nil) {
        title = name
        if backButton {
            navigationController?.navigationBar.barTintColor = UIColor.titleColor()
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: (backAction))
            backButton.tintColor = UIColor.titleColor()
            navigationItem.setLeftBarButton(backButton,
                                            animated: true)
        }
        if forwardButton {
            let episodeButton = UIBarButtonItem(title: "Episodes",
                                                style: .plain,
                                                target: self,
                                                action: forwardAction)
            episodeButton.tintColor = .white
            navigationItem.setRightBarButton(episodeButton, animated: true)
        }
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = backgroundColor
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor ]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    func configButtonsAndLabelsStack(buttons: [UIButton],
                                     labels: [UILabel]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons,
                                     axis: .vertical,
                                     spacing: 12,
                                     alignment: .fill)
        let stackView1 = UIStackView(arrangedSubviews: labels,
                                     axis: .vertical,
                                     spacing: 8,
                                     alignment: .fill)
        let stackView2 = UIStackView(arrangedSubviews: [stackView,stackView1],
                                 axis: .horizontal, spacing: 10, alignment: .center)
        return stackView2
    }
    
    func configStatusAndResetStack(label: UILabel,
                                   button: UIButton) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, button],
                                    axis: .horizontal,
                                    spacing: 0, alignment: .fill)
        return stackView
    }

}



