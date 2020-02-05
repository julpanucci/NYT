//
//  ArticleCell.swift
//  NYT
//
//  Created by Julian Panucci on 2/5/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    var article: Article?
    
    private let imageViewWidth: CGFloat = 100.0
    
    var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()
    
    var headLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(articleImageView)
        self.contentView.addSubview(headLineLabel)
        self.contentView.addSubview(descriptionLabel)
        
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            articleImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            articleImageView.widthAnchor.constraint(equalToConstant: self.imageViewWidth),
            
            headLineLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            headLineLabel.leadingAnchor.constraint(equalTo: self.articleImageView.leadingAnchor, constant: 8),
            headLineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.headLineLabel.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.headLineLabel.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.headLineLabel.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
