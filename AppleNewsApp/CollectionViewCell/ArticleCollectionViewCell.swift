//
//  ArticleCollectionViewCell.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell, ArticleCollectionViewCellProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    func configureCell(viewModel: NewsViewModel,article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        viewModel.getImage(imageUrl: article.urlToImage, completion: { [weak self] (image, error) in
            
            DispatchQueue.main.async {
                self?.articleImageView.image = image ?? UIImage()
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
    }
}

protocol ArticleCollectionViewCellProtocol {
    func configureCell(viewModel: NewsViewModel,article: Article)
}
