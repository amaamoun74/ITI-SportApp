//
//  LeagueDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
 
    var flag : Bool = false
    var teamsList = Array<Event>()
    var upcomingEventsList = Array<Event>()
    var latestResultsList = Array<Event>()
    var upcomingEventsViewModel : EventsViewModel?
    var latestResultsViewModel : EventsViewModel?
    var dataSavingViewModel : DataSavingViewModel?
    
    @IBOutlet weak var leagueName: UINavigationItem!
    @IBOutlet weak var favHeart: UIButton!
    @IBAction func addLeagueToFavourites(_ sender: Any) {
        if flag == false{
            favHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            flag = true
            
            dataSavingViewModel = DataSavingViewModel()
            dataSavingViewModel?.dataSaving.saveLeagueToFavourites(event: upcomingEventsList[0], appDelegate: AppDelegate())
        }
        else if flag == true
        {
            favHeart.setImage(UIImage(systemName: "heart"), for: .normal)
            flag = false
        }
    }
    
    @IBOutlet weak var teamsCollectionview: UICollectionView!
    @IBOutlet weak var upcomingEventsCollectionview: UICollectionView!
    @IBOutlet weak var latestResultsCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamsCollectionview.delegate = self
        teamsCollectionview.dataSource = self
        upcomingEventsCollectionview.delegate = self
        upcomingEventsCollectionview.dataSource = self
        latestResultsCollectionview.delegate = self
        latestResultsCollectionview.dataSource = self
        
        upcomingEventsViewModel = EventsViewModel()
        latestResultsViewModel = EventsViewModel()
        self.upcomingEventsViewModel?.getEvents(startDate: "2023-01-18", endDate: "2024-01-25")
        self.upcomingEventsViewModel?.bindResultToEvents = { () in         self.workingWithDispatchGroup()
}
        self.latestResultsViewModel?.getEvents(startDate:  "2022-01-18", endDate: "2023-01-25")
        self.latestResultsViewModel?.bindResultToEvents = { () in            self.workingWithDispatchGroup()
    }
        // self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Background")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == teamsCollectionview)
        {
            return 1
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            return 1
        }
        else if (collectionView == latestResultsCollectionview)
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == teamsCollectionview)
        {
            return teamsList.count
        }
        else if(collectionView == upcomingEventsCollectionview)
        {
            return upcomingEventsList.count
        }
        else if(collectionView == latestResultsCollectionview)
        {
            return latestResultsList.count
        }
        else
        {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == teamsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.teamImage.kf.setImage(with: URL(string: teamsList[indexPath.row].home_team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.teamImage.clipsToBounds = true
            cell.teamImage.layer.cornerRadius = cell.teamImage.frame.size.width / 2
            return cell
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
            cell.upcomingEventFirstTeam.text = upcomingEventsList[indexPath.row].event_home_team
            cell.upcomingEventSecondTeam.text = upcomingEventsList[indexPath.row].event_away_team
            cell.upcomingEventDate.text = upcomingEventsList[indexPath.row].event_date
            cell.upcomingEventTime.text = upcomingEventsList[indexPath.row].event_time
            cell.upcomingVs.layer.masksToBounds = true
            cell.upcomingVs.layer.cornerRadius = 12
            return cell
        }
        else if (collectionView == latestResultsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
            cell.latestResultsFirstTeam.text = latestResultsList[indexPath.row].event_home_team
            cell.latestResultsSecondTeam.text = latestResultsList[indexPath.row].event_away_team
            cell.latestResultsDate.text = latestResultsList[indexPath.row].event_date
            cell.latestResultsTime.text = latestResultsList[indexPath.row].event_time
            cell.latestResultsResult.text = latestResultsList[indexPath.row].event_final_result
            cell.latestResultsResult.layer.masksToBounds = true
            cell.latestResultsResult.layer.cornerRadius = 12
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: " ", for: indexPath) as! LeagueCollectionViewCell
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == teamsCollectionview)
        {
            var teamDetails = TeamDetailsVC()
            teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsVC
            teamDetails.displayedTeamKey = teamsList[indexPath.row].home_team_key
            self.navigationController?.pushViewController(teamDetails, animated: true)
        }
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == teamsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width/3)-20,height: (UIScreen.main.bounds.size.height)-50)
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width/1.6)-20,height: (UIScreen.main.bounds.size.height/4.2)-50)
        }
        else if (collectionView == latestResultsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width)-40,height: (UIScreen.main.bounds.size.height/5)-50)
        }
        else
        {
            return CGSize(width: (UIScreen.main.bounds.size.width)-20,height: (UIScreen.main.bounds.size.height)-50)
        }
    }
    
}

extension LeagueDetailsVC
{
    func workingWithDispatchGroup()
    {
        let group = DispatchGroup()
        
        group.enter()
         group.leave()
        
        group.enter()
        self.latestResultsList = self.latestResultsViewModel?.responce ?? []

        self.upcomingEventsList = self.upcomingEventsViewModel?.responce ?? []
          //      self.leagueName.title = self.upcomingEventsList[0].league_name
        group.leave()
        
        group.enter()
        
        self.teamsList = self.latestResultsViewModel?.responce ?? []

        group.leave()
        
        group.notify(queue: .main)
        {
            self.teamsCollectionview.reloadData()
            self.upcomingEventsCollectionview.reloadData()

        }
    }
   
}


