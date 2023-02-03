//
//  File.swift
//  SportApp
//
//  Created by ahmed on 03/02/2023.
//

import Foundation
class SportModel {
    
    var sportImage:String?
    var sportTitle: String?
    
    init(sportImage: String? = nil, sportTitle: String? = nil) {
        self.sportImage = sportImage
        self.sportTitle = sportTitle
    }
}
