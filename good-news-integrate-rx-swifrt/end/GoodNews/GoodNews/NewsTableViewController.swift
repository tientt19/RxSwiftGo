//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Mohammad Azam on 3/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let disposedBag = DisposeBag()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { fatalError("Cell not found") }
        cell.lbl_title.text = self.articles[indexPath.row].title
        cell.lbl_description.text = self.articles[indexPath.row].description
        return cell
    }
    
    private func populateNews() {
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                if let articles = result?.articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposedBag)
    }
}
