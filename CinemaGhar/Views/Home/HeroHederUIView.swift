//
//  HeroHederUIView.swift
//  CinemaGhar
//
//  Created by pooja kamble on 10/12/25.
//

import UIKit

class HeroHederUIView: UIView {

    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "HeroImage")
        return imageView
    }()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downlodButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(heroImageView)
        addSubview(playButton)
        addSubview(downlodButton)
        addGradient()
        applyConstraints()
        

        
     
    }
    
    private func applyConstraints() {

        let stack = UIStackView(arrangedSubviews: [playButton, downlodButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            stack.widthAnchor.constraint(equalToConstant: 260), 
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
