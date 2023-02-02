//
//  ViewController.swift
//  SportApp
//
//  Created by ahmed on 31/01/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {

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
        return 12
    }

    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SportsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SportsCollectionViewCell
        
        
         cell.SportName.text = "Football"
         cell.cellImage.image = UIImage(named: "sport")
        
        //let url = URL(string: imageList[indexPath.row])
        //cell.iv_image?.kf.setImage(with: url)

        
        
        return cell
    }

    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2), height: (UIScreen.main.bounds.size.width/2))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 15 // Keep whatever fits for you
    }
}

