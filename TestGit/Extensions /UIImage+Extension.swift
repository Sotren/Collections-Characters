//
//  UIImage+Extension.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 11.05.2022.
//

import Foundation
import  UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        image = nil
        guard let url = URL(string: URLAddress) else {
            return
        }
        if let imageFromCache = imageCache.object(forKey: URLAddress as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        if let imageData = try? Data(contentsOf: url) {
            if let loadedImage = UIImage(data: imageData) {
                imageCache.setObject(loadedImage, forKey: URLAddress as NSString )
                self.image = loadedImage
            }
        }
    }
}

