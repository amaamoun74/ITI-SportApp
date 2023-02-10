//
//  LeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit
import Reachability
class LeagueViewController: UIViewController{
    
    @IBOutlet weak var leagueTable: UITableView!
    var leagueArray = [League]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNibFile()
        leagueTable.delegate = self
        leagueTable.dataSource = self
        handleDataFetching()
    }
    
    func configurationNibFile(){
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        
        leagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension LeagueViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellTitle.text = leagueArray[indexPath.row].league_name
        //cell.cellImage.image = UIImage(named: "sport")
        let url = URL(string: (leagueArray[indexPath.row].league_logo ?? "https://m.media-amazon.com/images/M/MV5BZDc4MzVkNzYtZTRiZC00ODYwLWJjZmMtMDIyNjQ1M2M1OGM2XkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_Ratio0.6716_AL_.jpg" ))
        cell.cellImage?.kf.setImage(with: url)
        return cell
    }
    
}

extension LeagueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToNextScene()
    }
}

extension LeagueViewController {
    func checkNetworkAvilability() -> Bool{
        if Reachability.forInternetConnection().isReachable(){
            return true }
        else {
            return false
        }
    }
    
    func getLeagues(){
        let allLeaguesViewodel = AllLeaguesViewodel()
        allLeaguesViewodel.fetchData(endPoint: "football")
        allLeaguesViewodel.bindingData = { leaguesResult, error in
              if let leagues = leaguesResult {
                  self.leagueArray = leagues.result ?? []
                  DispatchQueue.main.async {
                      self.leagueTable.reloadData()
                  }
              }
              if let error = error {
                  print(error.localizedDescription)
              }
          }
        
    }
}

extension LeagueViewController: CustomViewDelegate
{
    func navigateToNextScene() {
        performSegue(withIdentifier: "webView", sender: self)
    }
    
    func showErrorAlert(){
        let alert : UIAlertController = UIAlertController(title:"Add" , message: "No network connection !", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "try again", style: .default , handler: { action in
            self.handleDataFetching()
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: { action in
        }))
        
        self.present(alert, animated: true , completion: nil )
    }
    private func handleDataFetching(){
        if checkNetworkAvilability() {
            getLeagues()
        }
        else
        {
            showErrorAlert()
        }
    }
}
