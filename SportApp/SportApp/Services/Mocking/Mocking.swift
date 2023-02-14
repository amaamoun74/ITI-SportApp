//
//  Mocking.swift
//  SportApp
//
//  Created by ahmed on 13/02/2023.
//

import Foundation
class Mocking {
    static let sharedInstance = Mocking()
    let mockResponse = "{\"success\": 1,\"result\":[]}"
    
    private init(){}
    
    
    func fetchMovieData(compilationHandler: @escaping(JsonResponse<League>?, Error?) -> Void) {
        let data = Data(mockResponse.utf8)
        
        do{
            let result = try JSONDecoder().decode(JsonResponse<League>.self, from: data)
            compilationHandler(result , nil)
        }
        catch {
            compilationHandler(nil , error)
        }
    }
}
