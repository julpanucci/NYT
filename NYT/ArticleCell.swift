//
//  ArticleCell.swift
//  NYT
//
//  Created by Julian Panucci on 2/5/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    let placeholderImage = UIImage(named: "placeholder.png")
    
    var article: Article? {
        didSet {
            self.articleImageView.kf.setImage(with: self.article?.thumbnailURL, placeholder: placeholderImage)
            self.headLineLabel.text = self.article?.headline?.main
            self.descriptionLabel.text = self.article?.byline?.original
        }
    }
    
    private let imageViewWidth: CGFloat = 100.0
    
    var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var headLineLabel: NoPaddingLabel = {
        let label = NoPaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 1
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
            
            headLineLabel.topAnchor.constraint(equalTo: self.articleImageView.topAnchor, constant: 0),
            headLineLabel.leadingAnchor.constraint(equalTo: self.articleImageView.trailingAnchor, constant: 8),
            headLineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            headLineLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant:  -4),
            

            descriptionLabel.leadingAnchor.constraint(equalTo: self.headLineLabel.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.headLineLabel.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}
