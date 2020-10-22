//
//  ViewExtension.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import UIKit

extension UIView {
    func showLoader(_ color: UIColor? = UIColor.white.withAlphaComponent(0.5) ,
                    isTop: Bool? = false, isLarge: Bool? = false) {
        
        let loaderView  = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        if (self.viewWithTag(-3 + self.tag))?.isDescendant(of: self) ?? false {
            return
        }
        loaderView.tag = -3 + self.tag
        loaderView.backgroundColor = color
        var loader: UIActivityIndicatorView?
        if isTop ?? false {
            loader = UIActivityIndicatorView(frame: CGRect(x: loaderView.center.x - 30, y: 30, width: 60, height: 30))
        }else{
            loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
            if isLarge ?? false {
                let transform: CGAffineTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                loader?.transform = transform
                loader?.frame = CGRect(x: loaderView.center.x - 35, y: 86, width: 80, height: 80)
                loaderView.backgroundColor = .clear
            } else {
                loader?.center = loaderView.center
                loaderView.backgroundColor = color
            }
        }
        loader?.color = .lightGray
        loader?.startAnimating()
        loaderView.addSubview(loader!)
        self.addSubview(loaderView)
    }
    
    func dismissLoader() {
        self.viewWithTag(-3 + self.tag)?.removeFromSuperview()
        
    }
}
