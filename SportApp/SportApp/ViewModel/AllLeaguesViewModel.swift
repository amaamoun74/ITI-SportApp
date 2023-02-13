//
//  AllLeaguesViewModel.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation

class AllLeaguesViewodel {
    
    var allLeaguesArray: [League] = []
    

    let apiService: ApiService
    var bindingData: ((JsonResponse<League>?,Error?) -> Void) = {_, _ in }
        
    var leaguesPerPages = 10
    var limit = 10
    var paginationLeagues: [League]?
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    var allResponse:JsonResponse<League>? {
        didSet{
            bindingData(allResponse ,nil)
        }
    }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }

    //MARK: - Public funcs
    func fetchData(endPoint: String) {
        apiService.getAllLeagues(endPoint: endPoint) { leaguesResult, error in
            if let leagues = leaguesResult {
                self.allResponse = leagues
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getLeaguesCount() -> Int {
        return self.paginationLeagues?.count ?? 0
    }
    
    func willDisplayMoreLeagues(at row: Int) {
        if let pagination = paginationLeagues {
            if row == pagination.count - 1 {
                getMoreLeagues()
            }
        }
    }
}
   
extension AllLeaguesViewodel{
    //MARK: - Private funcs
    private func getMoreLeagues() {
        if leaguesPerPages >= limit {
            return
        }
        else if leaguesPerPages >= limit - 10 {
            for i in leaguesPerPages..<limit {
                paginationLeagues?.append(self.allLeaguesArray[i])
            }
            self.leaguesPerPages += 10
        }
        else {
            for i in leaguesPerPages..<leaguesPerPages + 10 {
                paginationLeagues?.append(self.allLeaguesArray[i])
            }
            self.leaguesPerPages += 10
        }
    }
    
}
