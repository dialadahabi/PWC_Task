//
//  NewsViewController.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit
import SVGKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet var emptyView: UIView!
    
    var countryName: String?
    
    private let presenter = NewsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        configureNewsView()
        presenter.getNews(country: CountriesList.shared.countries?.filter({$0.name == countryName}).first?.code ?? "")
    }
    
    private func configureNewsView() {
        title = countryName
        countryNameLabel.text = countryName
        guard let flagURL = URL(string: CountriesList.shared.countries?.filter({$0.name == countryName}).first?.flag ?? "") else {return}
        let svg = flagURL
        let data = try? Data(contentsOf: svg)
        let receivedimage: SVGKImage = SVGKImage(data: data)
        countryFlagImageView.image = receivedimage.uiImage
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNewsData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.configure(article: presenter.getNewsData()?[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: presenter.getNewsData()?[indexPath.row].url ?? "") {
            UIApplication.shared.open(url)
        }
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
    
    func setEmptyView() {
        tableView.backgroundView = emptyView
        countryFlagImageView.isHidden = true
        countryNameLabel.isHidden = true
        tableView.separatorStyle = .none
    }
    
}
