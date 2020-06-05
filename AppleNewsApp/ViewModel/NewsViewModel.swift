//
//  NewsViewModel.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import UIKit

class NewsViewModel: NewsViewModelServiceProtocol {
   
    var articles: [Article] = []
    
    func fetchNewsArticles (completion: @escaping (([Article]?, NetworkError?))-> Void) {
        ServiceManager.sharedInstance.getApiResult(url: newsEndPoint) { [weak self] result in
            switch result {
            case .success(let data):
                if let jsonData = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                    self?.articles = jsonData.articles
                    completion((self?.articles, nil))
                }
            case .failure(let error):
                completion((nil, error))
            }
        }
    }
    
    func getImage(imageUrl: String, completion:@escaping ((UIImage?,NetworkError?))-> Void) {
        ServiceManager.sharedInstance.getApiResult(url: imageUrl) { (result) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion((image, nil))
                }
            case .failure(let error):
                completion((nil, error))
            }
        }
    }
}

 protocol NewsViewModelServiceProtocol {
    func getImage(imageUrl: String, completion:@escaping ((UIImage?,NetworkError?))-> Void)
    func fetchNewsArticles (completion: @escaping (([Article]?, NetworkError?))-> Void)
}
