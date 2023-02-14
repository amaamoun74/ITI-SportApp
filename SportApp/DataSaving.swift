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
        league.setValue(true , forKey: "league_state")
        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func isFavouriteLeague (leagueKey: Int, appDelegate : AppDelegate) -> Bool
    {
        var state : Bool?
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")
        let pred = NSPredicate(format: "league_key == %i", leagueKey )
        fetchRequest.predicate = pred
            do{
                state = try  managedContext.fetch(fetchRequest)[0].value(forKey: "league_state") as? Bool
            }catch let error{
                print(error.localizedDescription)
            }
        if state == true
        {
            return true
        }
        else
        {
            return false
        }
    }

}

