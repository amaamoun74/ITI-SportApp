//
//  FavouriteLeaguesVM.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation
class FavouriteLeaguesVM {
    var bindingData: (([League]?,Error?) -> Void) = {_, _ in }
    
    var savedLeaguesArray:[League]? {
        didSet {
            bindingData(savedLeaguesArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    
    let dataCaching: IDataCaching
    init(dataCaching : IDataCaching = DataManager()) {
        self.dataCaching = dataCaching
    }
    
    func fetchSavedLeagues (appDelegate : AppDelegate){
        dataCaching.fetchSavedLeagues(appDelegate: appDelegate) { result , error in
            if let leagues = result {
                self.savedLeaguesArray = leagues
            }
            if let error = error {
                self.error = error
            }
            
        }
    }
    
    func deleteLeagueItemFromFavourites (appDeleget : AppDelegate , leagueItem: League)
    {
        dataCaching.deleteLeagueFromFavourites(appDelegate: appDeleget, item: leagueItem) { errorMsg in
            guard let error = errorMsg else {
                return
            }
            self.error = error
            
        }
    }
    
}
