//
//  ViewController.swift
//  SportApp
//
//  Created by ahmed on 31/01/2023.
//

import UIKit
import TTGSnackbar
class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    private var sportArray : [SportModel] = [SportModel]()
    @IBOutlet weak var sportsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsCollection.delegate = self
        sportsCollection.dataSource = self
        self.navigationItem.title = "Sports"
        getSports()
    }
    func getSports(){
        let sportVM = SportViewModel()
        sportVM.getSportList()
            self.sportArray = sportVM.sportList ?? []
            DispatchQueue.main.async {
                self.sportsCollection.reloadData()
            }
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
        if sportArray[indexPath.row].sportImage == "football" || sportArray[indexPath.row].sportImage == "basketball" || sportArray[indexPath.row].sportImage == "tennis" || sportArray[indexPath.row].sportImage == "cricket"
        {
            UserDefaults.standard.set(sportArray[indexPath.row].sportImage , forKey: Constants.sharedInstance.ENDPOINT_KEY)
            navigateToNextScene()
        }
        else
        {
            showSnakbar(msg: "sorry can't open \(sportArray[indexPath.row].sportTitle)")
        }
     
    }
    private func showSnakbar(msg : String){
        let snackbar = TTGSnackbar(
            message: msg,
            duration: .middle
        )
        snackbar.actionTextColor = UIColor.blue
        snackbar.borderColor = UIColor.black
        snackbar.messageTextColor = UIColor.white
        snackbar.show()
    }
    
    private func navigateToNextScene(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllLeagues")
        navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2.1), height: (UIScreen.main.bounds.size.width/3))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 15 // Keep whatever fits for you
    }
}

