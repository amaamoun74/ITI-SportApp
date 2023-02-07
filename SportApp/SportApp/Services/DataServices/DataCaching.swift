//
//  DataCaching.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation
import CoreData
class DataCaching {
    static let sharedInstance = DataCaching()
    private init(){}
    
    func fetchSavedLeagues(appDelegate : AppDelegate) -> [League] {
        
            
            var leagueArray: [League] = []
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")
            
            do {
                let fetchedLeagueArray = try managedContext.fetch(fetchRequest)
                for item in (fetchedLeagueArray)
                {
                    var league = League()
                    league.league_name = item.value(forKey:"league_name") as? String
                    league.league_logo = item.value(forKey: "league_logo") as? String
                    league.league_key = item.value(forKey: "league_key") as? Int
                    league.country_key = item.value(forKey: "country_key") as? Int
                    league.country_name = item.value(forKey: "country_name") as? String
                    league.country_logo = item.value(forKey: "country_logo") as? String
                    
                    leagueArray.append(league)
                }
                
            
        } catch let error {
            print("fetch all leagues error :", error)
        }
        return leagueArray
    }
    
}
