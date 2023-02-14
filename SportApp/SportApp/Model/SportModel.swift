//
//  File.swift
//  SportApp
//
//  Created by ahmed on 03/02/2023.
//

import Foundation
class SportModel {
    
    var sportImage:String
    var sportTitle: String
    
    init(sportImage: String, sportTitle: String) {
        self.sportImage = sportImage
        self.sportTitle = sportTitle
    }
}

class SportManager{
    
    static let sharedInstance = SportManager()
    private init(){}
    func getSportList(completion: @escaping (([SportModel]? ) -> Void) )
    {
        let sportArray : [SportModel] = [SportModel(sportImage: "football", sportTitle: "Football"), SportModel(sportImage: "basketball", sportTitle: "Basketball") , SportModel(sportImage: "baseball", sportTitle: "Baseball") , SportModel(sportImage: "cricket", sportTitle: "Cricket") , SportModel(sportImage: "americanFootball", sportTitle: "American Football") ,SportModel(sportImage: "tennis", sportTitle: "Tennis") ,SportModel(sportImage: "hockey", sportTitle: "Hockey")]
        completion(sportArray)
    }
}
