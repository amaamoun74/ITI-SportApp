//
//  DataManager.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation

class DataManager:IDataCaching {
    func saveLeagueToFavourites(event: Event, appDelegate: AppDelegate) {
        dbManger.saveLeagueToFavourites(event: event, appDelegate: appDelegate)
    }
    
    
    let dbManger = DataCaching.sharedInstance
    func fetchSavedLeagues(appDelegate: AppDelegate, completion: @escaping (([League]? ,Error?) -> Void)) {
        completion(dbManger.fetchSavedLeagues(appDelegate: appDelegate), "Fetching Saved Leagues Error" as? Error)
    }
    
    func deleteLeagueFromFavourites(appDelegate: AppDelegate, leagueKey: Int , completion: (Error?) -> Void){
        dbManger.deleteLeagueFromFavourites(appDelegate: appDelegate, league_key: leagueKey ) { _ in
            
        }
    }
    
    
    
    
}
