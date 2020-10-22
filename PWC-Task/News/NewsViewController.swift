//
//  NewsViewController.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = NewsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.getNews(country: "us")
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNewsData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.configure(article: presenter.getNewsData()?[indexPath.row])
        return cell
    }
    
}

extension NewsViewController: NewsView {
    func startLoading() {
        view.showLoader()
    }
    
    func finishLoading() {
        view.dismissLoader()
    }
    
    func setSucceeded() {
        tableView.reloadData()
    }
    
    func didGetError() {
        
    }
    
    
}
