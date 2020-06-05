//
//  HomeViewController.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsArticlesCollectionView: UICollectionView!
    
    var viewModel: NewsViewModel!
    var filteredNewsArticles: [Article] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = homeVCTitle
        viewModel = NewsViewModel()
        getNewArticles()
    }
    
    //MARK: - Fetch Articles
    private func getNewArticles() {
        viewModel.fetchNewsArticles { (articles, error) in
            if error != nil {
                // Show Alert View
                DispatchQueue.main.async {
                    self.showAlert(message: error?.description)
                }
            } else {
                self.filteredNewsArticles = articles ?? []
                DispatchQueue.main.async {
                    self.newsArticlesCollectionView.reloadData()
                }
            }
        }
    }
}

//MARK: - UICollectionViewDataSource UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNewsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: articleCellIdentifier, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(viewModel: viewModel, article: self.filteredNewsArticles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: detailVCIdentifier) as? DetailArticleViewController else { return }
        let article = filteredNewsArticles[indexPath.row]
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArticleCollectionViewCell else { return }
        detailVC.article = article
        let image = cell.articleImageView.image
        detailVC.articleImage = image
        navigationController?.pushViewController(detailVC, animated: false)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        return CGSize (width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let enteredText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !enteredText.isEmpty {
            filteredNewsArticles = viewModel.articles.filter({ (article) -> Bool in
                article.title.lowercased().contains(enteredText) || article.description.lowercased().contains(enteredText) || article.content.lowercased().contains(enteredText)
                })
        } else {
            filteredNewsArticles = viewModel.articles
        }
        self.newsArticlesCollectionView.reloadData()
    }
}
