//
//  NewsCell.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    func configure(article: Article?) {
        guard let article = article else {return}
    }
    
}
