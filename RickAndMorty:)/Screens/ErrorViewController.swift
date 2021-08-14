//
//  ErrorViewController.swift
//  RickAndMorty
//
//  Created by Антон on 14.08.2021.
//

import UIKit

class ErrorVieController: UIViewController {
    
    let image = UIImageView(image: UIImage(named: "rick_morty_PNG19"))
    let label = UILabel(text: "Nothing There Morty...", color: .label, font: 35,
                        lines: 0, weight: .heavy, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupVieew()
    }
    
    private func setupVieew() {
        [image,label].forEach { view.addSubview($0)}
        image.frame = view.bounds
        image.contentMode = .scaleAspectFit
        label.constraint(left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, leftConstant: 20, bottomConstant: 20, rightConstant: 20, heightConstant: view.bounds.height / 5)
    }
}
