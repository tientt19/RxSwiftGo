//
//  Article.swift
//  GoodNews
//
//  Created by Tiến Trần on 09/09/2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c155d7dfd58b40ad9568f6cd6ea390d5")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
