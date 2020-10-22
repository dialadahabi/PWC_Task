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

extension NewsViewController: NewsView {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setSucceeded() {
        
    }
    
    func didGetError() {
        
    }
    
    
}
