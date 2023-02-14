//
//  Mocking.swift
//  SportApp
//
//  Created by ahmed on 13/02/2023.
//

import Foundation
class Mocking {
    private init(){}
     static let mockResponseItem = "{\"success\": 1,\"result\":[]}"
    

    
    static func fetchMovieData(compilationHandler: @escaping (JsonResponse<League>?, Error?) -> Void) {
        let data = Data(mockResponseItem.utf8)
        
        do{
            let result = try JSONDecoder().decode(JsonResponse<League>.self, from: data)
            compilationHandler(result , nil)
        }
        catch {
            compilationHandler(nil , error)
        }
    }
}
