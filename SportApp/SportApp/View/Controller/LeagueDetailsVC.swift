//
//  LeagueDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsVC: UIViewController {
    
    private let group = DispatchGroup()
    private var leagueState : Bool = false
    private var flag : Bool = false
    private var teamsList = Array<Team>()
    private var upcomingEventsList = Array<Event>()
    private var latestResultsList = Array<Event>()
    private var upcomingEventsViewModel : EventsViewModel?
    private var latestResultsViewModel : EventsViewModel?
    private var teamsViewModel : TeamsViewModel?
    private var dataSavingViewModel : FavouriteLeaguesVM?
    var urlHelper: URLHelper = URLHelper(endPoint: "" , leagueId: 0)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var myEvent : Event = Event()
    
    @IBOutlet weak var leagueName: UINavigationItem!
    @IBOutlet weak var upcomingEvents: UILabel!
    @IBOutlet weak var latestResults: UILabel!
    @IBOutlet weak var favHeart: UIButton!
    @IBAction func addLeagueToFavourites(_ sender: Any) {
        if flag == false && leagueState == false{
            favHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            flag = true
            self.myEvent.event_endPoint = self.urlHelper.endPoint ?? "football"
            dataSavingViewModel = FavouriteLeaguesVM()
            dataSavingViewModel?.saveLeague(appDelegate: appDelegate, eventItem: myEvent)
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
        teamsViewModel = TeamsViewModel()
        self.workingWithDispatchGroup()
        self.upcomingEvents.font = UIFont.boldSystemFont(ofSize: 17)
        self.latestResults.font = UIFont.boldSystemFont(ofSize: 17)
       
    }
     override func viewWillAppear(_ animated: Bool) {
        dataSavingViewModel = FavouriteLeaguesVM()
         leagueState = ((dataSavingViewModel?.isFavourite(appDelegate: appDelegate, leagueKey: urlHelper.leagueId ?? 0)) == true)
        if leagueState == true
        {
           favHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}

extension LeagueDetailsVC : UICollectionViewDataSource
{
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
            cell.teamImage.kf.setImage(with: URL(string: teamsList[indexPath.row].team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.teamImage.clipsToBounds = true
            cell.teamImage.layer.cornerRadius = cell.teamImage.frame.size.width / 2
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)

            return cell
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
       //     if urlHelper.endPoint == "tennis"
                
            cell.upcomingEventHomeTeamImage.kf.setImage(with: URL(string: upcomingEventsList[indexPath.row].home_team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.upcomingEventAwayTeamImage.kf.setImage(with: URL(string: upcomingEventsList[indexPath.row].away_team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.upcomingEventFirstTeam.text = upcomingEventsList[indexPath.row].event_home_team
            cell.upcomingEventSecondTeam.text = upcomingEventsList[indexPath.row].event_away_team
            cell.upcomingEventDate.text = upcomingEventsList[indexPath.row].event_date
            cell.upcomingEventTime.text = upcomingEventsList[indexPath.row].event_time
            cell.upcomingVs.layer.masksToBounds = true
            cell.upcomingVs.layer.cornerRadius = 14
            return cell
        }
        else if (collectionView == latestResultsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
            cell.latestResultHomeTeamImage.kf.setImage(with: URL(string: latestResultsList[indexPath.row].home_team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.latestResultAwayTeamImage.kf.setImage(with: URL(string: latestResultsList[indexPath.row].away_team_logo ?? " "),placeholder: UIImage(named: "P"))
            cell.latestResultsFirstTeam.text = latestResultsList[indexPath.row].event_home_team
            cell.latestResultsSecondTeam.text = latestResultsList[indexPath.row].event_away_team
            cell.latestResultsDate.text = latestResultsList[indexPath.row].event_date
            cell.latestResultsTime.text = latestResultsList[indexPath.row].event_time
            cell.latestResultsResult.text = latestResultsList[indexPath.row].event_final_result
            cell.latestResultsResult.layer.masksToBounds = true
            cell.latestResultsResult.layer.cornerRadius = 12
            cell.latestResultsResult.font = UIFont.boldSystemFont(ofSize: 25)

            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: " ", for: indexPath) as! LeagueCollectionViewCell
            return cell
        }
    }
}
extension LeagueDetailsVC : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == teamsCollectionview)
        {
            var teamDetails = TeamDetailsVC()
            teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsVC
            teamDetails.team = teamsList[indexPath.row]
            self.navigationController?.pushViewController(teamDetails, animated: true)
        }
    }
}
extension LeagueDetailsVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == teamsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width/3)-20,height: (UIScreen.main.bounds.size.height)-50)
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width/1.6)-20,height: (UIScreen.main.bounds.size.height/4)-50)
        }
        else if (collectionView == latestResultsCollectionview)
        {
            return CGSize(width: (UIScreen.main.bounds.size.width)-40,height: (UIScreen.main.bounds.size.height/4.5)-50)
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
        group.enter()
        self.upcomingEventsViewModel?.getEvents(endPoint: urlHelper.endPoint ?? "", leagueId: urlHelper.leagueId ?? 0, startDate: "2023-01-18", endDate: "2024-01-25")
        self.upcomingEventsViewModel?.bindResultToEvents = { () in
            self.upcomingEventsList = self.upcomingEventsViewModel?.responce ?? []
           // self.myEvent = self.upcomingEventsViewModel?.responce[0] ?? Event()
            self.leagueName.title = self.upcomingEventsList[0].league_name
            self.group.leave()
}
        group.enter()
        self.latestResultsViewModel?.getEvents(endPoint: urlHelper.endPoint ?? "", leagueId: urlHelper.leagueId ?? 0, startDate: "2022-01-18", endDate: "2023-01-25")
        self.latestResultsViewModel?.bindResultToEvents = { () in
            self.latestResultsList = self.latestResultsViewModel?.responce ?? []
            self.group.leave()
    }
        group.enter()
        teamsViewModel?.getTeams(endPoint: urlHelper.endPoint ?? "", leagueId: urlHelper.leagueId ?? 0)
            self.teamsViewModel?.bindResultToTeamDetailsVC = { ( ) in
            self.teamsList = self.teamsViewModel?.responce ?? []
            self.group.leave()

 }
        group.notify(queue: .main)
        {
            self.teamsCollectionview.reloadData()
            self.upcomingEventsCollectionview.reloadData()
            self.latestResultsCollectionview.reloadData()
        }
    }
}
