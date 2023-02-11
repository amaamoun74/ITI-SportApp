//
//  DataSaving.swift
//  SportApp
//
//  Created by Fatma on 11/02/2023.
//

import Foundation
import CoreData

class DataSaving : SavingData
{
    static let sharedInstance = DataSaving()
    private init(){}
    
    func saveLeagueToFavourites(event : Event, appDelegate : AppDelegate) -> Void
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavedLeague", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(event.league_key ?? 0, forKey: "league_key")
        league.setValue(event.league_name, forKey: "league_name")
        league.setValue(event.league_logo , forKey: "league_logo")
        league.setValue(event.event_country_key ?? 0, forKey: "country_key")
        league.setValue(event.country_name, forKey: "country_name")
        league.setValue(event.country_logo , forKey: "country_logo")
        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
}
