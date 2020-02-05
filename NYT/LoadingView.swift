//
//  LoadingView.swift
//  NYT
//
//  Created by Julian Panucci on 2/5/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    let animationSpeed: CGFloat = 1
    
    var descriptionText: String? = "Loading..."  {
        didSet {
            self.descriptionLabel.text = self.descriptionText
        }
    }
    
    var textColor: UIColor? = .black {
        didSet {
            self.descriptionLabel.textColor = self.textColor
        }
    }
    
    private lazy var lottieView: AnimationView = {
        let view = AnimationView(animation: Animation.named("loading_news"))
        view.frame.size = CGSize(width: self.bounds.width, height: 300)
        view.contentMode = .scaleAspectFit
        view.animationSpeed = self.animationSpeed
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = self.descriptionText
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lottieView)
        self.lottieView.center = self.center
        
        setContsraints()
    }
    
    func setContsraints() {
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 32),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: self.lottieView.bottomAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func startLoading() {
//        changeBallColor(color: .white)
//        changeShadowColor(color: .white)
        
        if !lottieView.isAnimationPlaying {
            lottieView.play(fromProgress: nil, toProgress: 1, loopMode: .loop, completion: nil)
        }
    }
    
    func changeBallColor(color: UIColor) {
        let keypath = AnimationKeypath(keypath: "**.Shape Layer 1.Ellipse 1.Fill 1.Color")
        let colorProvider = ColorValueProvider(color.lottieColorValue)
        lottieView.setValueProvider(colorProvider, keypath: keypath)
    }
    
    func changeShadowColor(color: UIColor) {
        let keypath2 = AnimationKeypath(keypath: "**.Shape Layer 2.Ellipse 1.Fill 1.Color")
        let colorProvider2 = ColorValueProvider(color.lottieColorValue)
        lottieView.setValueProvider(colorProvider2, keypath: keypath2)
    }
    
    func stopLoading() {
        
    }
}
