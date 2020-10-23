//
//  NewsWrapperModel.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation

struct NewsWrapperModel: Decodable {
    var articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
}
