//
//  ArticleLoadingView.swift
//  NYT
//
//  Created by Julian Panucci on 2/5/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit
import SkeletonView

class ArticleLoadingView: UIView {
    
    lazy var textView1: UITextView = {
        let textView = UITextView()
        textView.isSkeletonable = true
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var textView2: UITextView = {
        let textView = UITextView()
        textView.isSkeletonable = true
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var textView3: UITextView = {
        let textView = UITextView()
        textView.isSkeletonable = true
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var placeHolderView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()
    
    lazy var placeHolderView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()
    
    lazy var placeHolderView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isSkeletonable = true
        
        self.addSubview(placeHolderView1)
        self.addSubview(textView1)
        self.addSubview(textView2)
        self.addSubview(placeHolderView2)
        self.addSubview(textView3)
        self.addSubview(placeHolderView3)
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            placeHolderView1.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            placeHolderView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeHolderView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            placeHolderView1.heightAnchor.constraint(equalToConstant: 100),
            
            textView1.topAnchor.constraint(equalTo: placeHolderView1.bottomAnchor, constant: 8),
            textView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            textView1.heightAnchor.constraint(equalToConstant: 100),
            
            placeHolderView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),
            placeHolderView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeHolderView2.heightAnchor.constraint(equalToConstant: 100),
            placeHolderView2.widthAnchor.constraint(equalToConstant: 150),
            
            textView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),
            textView2.leadingAnchor.constraint(equalTo: placeHolderView2.trailingAnchor, constant: 8),
            textView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            textView2.heightAnchor.constraint(equalToConstant: 100),
            
            placeHolderView3.topAnchor.constraint(equalTo: placeHolderView2.bottomAnchor, constant: 8),
            placeHolderView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeHolderView3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            placeHolderView3.heightAnchor.constraint(equalToConstant: 100),
            
            textView3.topAnchor.constraint(equalTo: placeHolderView3.bottomAnchor, constant: 8),
            textView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textView3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            textView3.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            self.showAnimatedGradientSkeleton()
        }
        
    }
}
