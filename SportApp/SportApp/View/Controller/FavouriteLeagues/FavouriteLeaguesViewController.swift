//
//  SavedLeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit
import Reachability
import Kingfisher

class FavouriteLeaguesViewController: UIViewController {

    
    @IBOutlet weak var savedLeagueTable: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var savedLeagueArray = [League]()

    override func viewDidLoad() {
        super.viewDidLoad()
        savedLeagueTable.delegate = self
        savedLeagueTable.dataSource = self
        configurationNibFile()
        getSavedLeagues()
        
    }
    func configurationNibFile(){
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        
        savedLeagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension FavouriteLeaguesViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Saved Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedLeagueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellTitle.text = savedLeagueArray[indexPath.row].league_name
        let url = URL(string: (savedLeagueArray[indexPath.row].league_logo ?? "https://m.media-amazon.com/images/M/MV5BZDc4MzVkNzYtZTRiZC00ODYwLWJjZmMtMDIyNjQ1M2M1OGM2XkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_Ratio0.6716_AL_.jpg" ))
        cell.cellImage?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        validateNavigation()
    }
}

extension FavouriteLeaguesViewController {
    func getSavedLeagues(){
        
        let favouriteViewModel = FavouriteLeaguesVM()
        favouriteViewModel.fetchSavedLeagues(appDelegate: self.appDelegate)
        favouriteViewModel.bindingData = {result , error in
              if let savedLeagues = result {
                  self.savedLeagueArray = savedLeagues
                  DispatchQueue.main.async {
                      self.savedLeagueTable.reloadData()
                  }
              }
              if let error = error {
                  print(error.localizedDescription)
              }
          }
        
    }
}
extension FavouriteLeaguesViewController: CustomViewDelegate{
    func navigateToNextScene() {
        performSegue(withIdentifier: "secondStoryboard", sender: self)
    }
    
    private func showErrorAlert(){
        let alert : UIAlertController = UIAlertController(title:"Add" , message: "No network connection !", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "try again", style: .default , handler: { action in
            self.validateNavigation()
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: { action in
        }))
        
        self.present(alert, animated: true , completion: nil )
    }
    
    
    func validateNavigation(){
        if Reachability.forInternetConnection().isReachable()
            {
                self.navigateToNextScene()
                
            }
            else{
                showErrorAlert()
            }
        }
}
