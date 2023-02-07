//
//  NetworkManager.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation
class NetworkManager: ApiService {
    func getAllLeagues(endPoint: String, completion: @escaping ((JsonResponse<League>?, Error?) -> Void)) {
        if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodedArray: JsonResponse<League> = convertFromJson(data: data) ?? JsonResponse<League>()
                    completion(decodedArray,nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
        
    }
}
