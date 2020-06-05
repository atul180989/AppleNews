//
//  DetailArticleViewController.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {

    var article: Article!
    var articleImage : UIImage?
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setUpView()
    }
    private func setUpView() {
        articleTitleLabel.text = article.title
        articleAuthorLabel.text = "By: \(self.article.author)"
        articleDateLabel.text = "Updated: \(self.article.publishedAt.getFormattedDate())"
        articleDescriptionLabel.text = article.description
        articleContentLabel.text = article.content
        if (articleImage != nil) {
           articleImageView.image = articleImage
        }
    }

    @IBAction func onTapMoreButton(_ sender: Any) {
        guard let webVC = storyboard?.instantiateViewController(identifier: "WebDetailViewController") as? WebDetailViewController else { return }
        webVC.url = article?.url
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension String {
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let newDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "E, d MMM yyyy"
        let newDateString = dateFormatter.string(from: newDate ?? Date())
        return newDateString
    }
}
