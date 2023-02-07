//
//  DataManager.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation

class DataManager:IDataCaching {
    
    let dbManger = DataCaching.sharedInstance
    func fetchSavedLeagues(appDelegate: AppDelegate, completion: @escaping (([League]? ,Error?) -> Void)) {
        completion(dbManger.fetchSavedLeagues(appDelegate: appDelegate), "Fetching Saved Leagues Error" as? Error)
    }
    
  
    
    
    
    
}
