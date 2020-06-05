//
//  AppleNewsAppTests.swift
//  AppleNewsAppTests
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import XCTest
@testable import AppleNewsApp

class AppleNewsAppTests: XCTestCase {

    var viewModel: NewsViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = NewsViewModel()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNewsArticles() {
        viewModel.fetchNewsArticles { (articles, error) in
            XCTAssertTrue(articles?.count == 1)
            XCTAssertTrue(error == nil)
        }
        
        viewModel.getImage(imageUrl: "https://www.hetx.com/image.jpg") { (image, error) in
            XCTAssertTrue(image != nil)
            XCTAssertTrue(error == nil)
            
        }
    }
}

class MockNewsViewModelServiceProtocol:NewsViewModelServiceProtocol {
    func getImage(imageUrl: String, completion: @escaping ((UIImage?, NetworkError?)) -> Void) {
        completion((UIImage(),nil))
    }
    
    func fetchNewsArticles(completion: @escaping (([Article]?, NetworkError?)) -> Void) {
        let article  = Article(source: Source(id: "1", name: "Abc"), author: "Aman", title: "Top Storis", description: "Description", url: "https", urlToImage: "", publishedAt: "", content: "")
        completion(([article],nil))
    }
}
