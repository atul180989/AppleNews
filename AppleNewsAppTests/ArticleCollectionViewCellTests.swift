//
//  ArticleCollectionViewCellTests.swift
//  AppleNewsAppTests
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import XCTest
@testable import AppleNewsApp

class ArticleCollectionViewCellTests: XCTestCase {

    var viewModel: NewsViewModel!
    var article: Article!
    var mockCellObj: MockArticleCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        
        viewModel = NewsViewModel()
        article = Article(source: Source(id: "1", name: "Abc"), author: "Aman", title: "Top Storis", description: "Description", url: "https", urlToImage: "", publishedAt: "", content: "")
        mockCellObj = MockArticleCollectionViewCell()
    
    }

    override func tearDown() {
        
        super.tearDown()
        viewModel = nil
        article = nil
        mockCellObj = nil
    }

    func testInitialConfiguration() {
        mockCellObj.configureCell(viewModel: viewModel, article: article)
        XCTAssertTrue(mockCellObj.cellConfigured)
    }
}

class  MockArticleCollectionViewCell: ArticleCollectionViewCellProtocol {
    var cellConfigured: Bool = false
    
    func configureCell(viewModel: NewsViewModel, article: Article) {
        cellConfigured = true
    }
}
