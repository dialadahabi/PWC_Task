//
//  ImageViewExtension.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(using url: String,
                  placeholderImage: UIImage? = nil,
                  completion: ((UIImage?) -> Void)? = nil) {
        self.kf.setImage(with: URL(string: url), placeholder: placeholderImage, completionHandler:  { (result) in
            switch result {
            case .success(let imageResult):
                completion?(imageResult.image)
            case .failure(_):
                break
            }
        })
    }
}
