//
//  ErrorViewController.swift
//  RickAndMorty
//
//  Created by Антон on 14.08.2021.
//

import UIKit

class ErrorVieController: UIViewController {
    
    
    private let image = UIImageView(image: UIImage(named: "rick_morty_PNG19"))
    private let label = UILabel(text: """
                               Look Morty!
                              There nothing there!
                              """,
                                color: UIColor.titleColor(), font: 35,
                                lines: 0, weight: .heavy, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupVieew()
    }
    
    private func setupVieew() {
        [image,label].forEach { view.addSubview($0)}
        
        image.contentMode = .scaleAspectFit
        
       setupConstraints()
    }
    
  private func setupConstraints() {
    image.constraint(top: view.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     bottom: label.topAnchor,
                     topConstant: 0,
                     leftConstant: 0,
                     bottomConstant: 0,
                     rightConstant: 0)
        label.constraint(left: view.leftAnchor,
                         right: view.rightAnchor,
                         bottom: view.bottomAnchor,
                         leftConstant: 20,
                         bottomConstant: 10,
                         rightConstant: 20,
                         heightConstant: view.bounds.height / 5.2)
    }
}
