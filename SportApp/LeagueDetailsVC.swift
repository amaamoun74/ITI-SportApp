//
//  LeagueDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit

class LeagueDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
 
    var flag : Bool = false
    
    @IBOutlet weak var favHeart: UIButton!
    
    @IBAction func addLeagueToFavourites(_ sender: Any) {
        if flag == false{
            favHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            flag = true
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
            return 7
        }
        else if(collectionView == upcomingEventsCollectionview)
        {
            return 5
        }
        else if(collectionView == latestResultsCollectionview)
        {
            return 10
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
            cell.teamImage.image = UIImage(named: "L")
            cell.teamImage.clipsToBounds = true
            cell.teamImage.layer.cornerRadius = cell.teamImage.frame.size.width / 2
            return cell
        }
        else if (collectionView == upcomingEventsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
            return cell
        }
        else if (collectionView == latestResultsCollectionview)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as! LeagueCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20
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
            return CGSize(width: (UIScreen.main.bounds.size.width/2.5)-20,height: (UIScreen.main.bounds.size.height/5.1)-50)

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
