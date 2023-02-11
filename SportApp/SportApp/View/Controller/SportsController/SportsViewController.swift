//
//  ViewController.swift
//  SportApp
//
//  Created by ahmed on 31/01/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    private let sportArray : [SportModel] = [SportModel(sportImage: "football", sportTitle: "Football"), SportModel(sportImage: "basketball", sportTitle: "Basketball") , SportModel(sportImage: "tennis", sportTitle: "Tennis") , SportModel(sportImage: "cricket", sportTitle: "Cricket") , SportModel(sportImage: "americanFootball", sportTitle: "American Football") ,SportModel(sportImage: "hockey", sportTitle: "Hockey") , SportModel(sportImage: "baseball", sportTitle: "Baseball")]
    @IBOutlet weak var sportsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsCollection.delegate = self
        sportsCollection.dataSource = self
        self.navigationItem.title = "Sports"
    }
}

extension ViewController {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return sportArray.count
    }

    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SportsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SportsCollectionViewCell
        
        
         cell.SportName.text = sportArray[indexPath.row].sportTitle
         cell.cellImage.image = UIImage(named: sportArray[indexPath.row].sportImage)
        
        //let url = URL(string: imageList[indexPath.row])
        //cell.iv_image?.kf.setImage(with: url)
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2.1), height: (UIScreen.main.bounds.size.width/2))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 15 // Keep whatever fits for you
    }
}

