//
//  TeamDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit

class TeamDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var playersCollectionview: UICollectionView!
    
    @IBOutlet weak var teamImageFrame: UIView!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionview.delegate = self
        playersCollectionview.dataSource = self
        
        teamImageFrame.layer.masksToBounds = true
        teamImageFrame.layer.cornerRadius = teamImageFrame.frame.size.width/2
        teamImage.image = UIImage(named: "T")
        teamImage.layer.cornerRadius = teamImage.frame.size.width / 2
        teamImage.clipsToBounds = true
        view.bringSubviewToFront(teamImage)

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playersCell", for: indexPath) as! TeamCollectionViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 20
        
        cell.playerImage.image = UIImage(named: "P")
        cell.playerImage.clipsToBounds = true
        cell.playerImage.layer.cornerRadius = cell.playerImage.frame.size.width / 2

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/3)-20,height: (UIScreen.main.bounds.size.height/4.6)-50)
    }

}
