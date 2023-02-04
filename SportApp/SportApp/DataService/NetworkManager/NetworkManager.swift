//
//  NetworkManager.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation
class NetworkManager: ApiService {
    func getAllLeagues(endPoint: String, completion: @escaping ((AllLeagueResponse?, Error?) -> Void)) {
        if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodedArray: AllLeagueResponse = convertFromJson(data: data) ?? AllLeagueResponse()
                    completion(decodedArray,nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
        
    }
}
