//
//  AllLeaguesViewModel.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation

class AllLeaguesViewodel {
    
    var allLeaguesArray:JsonResponse<League>? {
        didSet {
            bindingData(allLeaguesArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: ((JsonResponse<League>?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    func fetchData(endPoint: String) {
        apiService.getAllLeagues(endPoint: endPoint) { leaguesResult, error in
            if let leagues = leaguesResult {
                self.allLeaguesArray = leagues
            }
            if let error = error {
                self.error = error
            }
        }
    }
        
    
}
