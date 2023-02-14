//
//  NetworkManager.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation
import Alamofire
class NetworkManager: ApiService {
 /*   func getAllLeagues(endPoint: String, completion: @escaping ((JsonResponse<League>?, Error?) -> Void)) {
        if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
            print("ok8ij7huygtfrgtyhuygtfghyhg")

            URLSession.shared.dataTask(with: url) { data, response, error in
                print(error?.localizedDescription  as Any)
                if let data = data {
                    let decodedArray: JsonResponse<League> = convertFromJson(data: data) ?? JsonResponse<League>()
                    completion(decodedArray,nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
        
    }*/
    
    func getAllLeagues(endPoint: String, completion: @escaping ((JsonResponse<League>?, Error?) -> Void)) {
        let  request = AF.request( UrlServices(endPoint: endPoint).url)
        request.responseDecodable (of: JsonResponse<League>.self) {(olddata) in
            guard let data = olddata.value
            else{
                completion(nil , "Fetching Leagues error" as? any Error)
                return
            }
            completion(data , nil)
        }
    }
}
