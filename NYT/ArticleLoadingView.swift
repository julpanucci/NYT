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

    lazy var label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()

    lazy var label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isSkeletonable = true

        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(placeHolderView1)
        self.addSubview(textView1)
        self.addSubview(textView2)
        self.addSubview(placeHolderView2)
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            label1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label1.widthAnchor.constraint(equalToConstant: 200),
            label1.heightAnchor.constraint(equalToConstant: 30),

            label2.topAnchor.constraint(equalTo: label1.topAnchor, constant: 64),
            label2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            label2.widthAnchor.constraint(equalToConstant: 200),
            label2.heightAnchor.constraint(equalToConstant: 30),

            textView1.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 8),
            textView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            textView1.heightAnchor.constraint(equalToConstant: 100),

            textView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),
            textView2.leadingAnchor.constraint(equalTo: textView1.leadingAnchor, constant: 0),
            textView2.trailingAnchor.constraint(equalTo: textView1.trailingAnchor, constant: 0),
            textView2.heightAnchor.constraint(equalToConstant: 100),

            placeHolderView1.topAnchor.constraint(equalTo: textView2.bottomAnchor, constant: 8),
            placeHolderView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeHolderView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            placeHolderView1.heightAnchor.constraint(equalToConstant: 250),
            
            placeHolderView2.topAnchor.constraint(equalTo: placeHolderView1.bottomAnchor, constant: 8),
            placeHolderView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeHolderView2.heightAnchor.constraint(equalToConstant: 100),
            placeHolderView2.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            self.showAnimatedGradientSkeleton()
        }
        
    }
}
