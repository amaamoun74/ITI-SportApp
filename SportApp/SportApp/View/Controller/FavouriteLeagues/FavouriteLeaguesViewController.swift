//
//  SavedLeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit

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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
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
