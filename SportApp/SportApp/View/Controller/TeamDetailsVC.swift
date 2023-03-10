//
//  TeamDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit

class TeamDetailsVC: UIViewController, UICollectionViewDelegate {
    
    var team = Team()
    
    @IBOutlet weak var playersCollectionview: UICollectionView!
    @IBOutlet weak var teamImageFrame: UIView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var players: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionview.delegate = self
        playersCollectionview.dataSource = self
     
        self.teamImageFrame.layer.masksToBounds = true
        self.teamImageFrame.layer.cornerRadius = self.teamImageFrame.frame.size.width/2
        self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width / 2
        self.teamImage.clipsToBounds = true
        self.view.bringSubviewToFront(self.teamImage)
        self.teamName.font = UIFont.boldSystemFont(ofSize: 32)
        self.teamName.text = self.team.team_name
        self.teamImage.kf.setImage(with: URL(string: self.team.team_logo ?? " "),placeholder: UIImage(named: "P"))
        self.coachName.text = "Coach Name : ".appending(self.team.coaches?[0].coach_name ?? "")
        self.coachName.layer.masksToBounds = true
        self.coachName.layer.cornerRadius = 12
        self.players.layer.masksToBounds = true
        self.players.layer.cornerRadius = 12

    //    self.teamDetailsScroll.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height)*2 )
        }
}

extension TeamDetailsVC : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team.players?.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playersCell", for: indexPath) as! TeamCollectionViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 20
   //     cell.layer.borderColor = (UIColor(named: "Font") as! CGColor)
   //     cell.layer.borderWidth = 5
        cell.playerName.text = team.players?[indexPath.row].player_name
        cell.playerName.font = UIFont.boldSystemFont(ofSize: 24)
        cell.playerNumber.text = team.players?[indexPath.row].player_number
        cell.playerNumber.font = UIFont.boldSystemFont(ofSize: 32)
        cell.playerType.text = team.players?[indexPath.row].player_type
        cell.playerAge.text = team.players?[indexPath.row].player_age?.appending(" years")
        
        cell.playerGoals.text = team.players?[indexPath.row].player_goals?.appending(" goals")

        cell.playerImage.kf.setImage(with: URL(string: team.players?[indexPath.row].player_image ?? " "),placeholder: UIImage(named: "P"))
        cell.playerImage.clipsToBounds = true
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.size.width / 2

        return cell
    }
}

extension TeamDetailsVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width)-40,height: (UIScreen.main.bounds.size.height/4)-50)
    }
}
