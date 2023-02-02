//
//  SavedLeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit

class SavedLeagueViewController: UIViewController {

    
    @IBOutlet weak var savedLeagueTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNibFile()
        savedLeagueTable.delegate = self
        savedLeagueTable.dataSource = self
        
    }
    func configurationNibFile(){
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        
        savedLeagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension SavedLeagueViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Saved Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellTitle.text = "Primier League"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
}
