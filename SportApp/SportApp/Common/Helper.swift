//
//  JsonDecoder.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import UIKit

func convertFromJson<T: Codable>(data: Data) -> T? {
    let jsonDecoder = JSONDecoder()
    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
    return decodedArray
}

var imageChaching = NSCache<AnyObject , AnyObject>()


extension UIImageView {
    func load(urlString : String){
        guard let url = URL(string: urlString) else {return}
        if let image = imageChaching.object(forKey: urlString as NSString) as? UIImage
        {
            self.image = image
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image  = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageChaching.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                }
            }
        }
        
    }
}
