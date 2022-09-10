//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Tiến Trần on 10/09/2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

extension ArticleResponse {
    static var all: Resource<ArticleResponse> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c155d7dfd58b40ad9568f6cd6ea390d5")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    var title: String
    var description: String?
}
