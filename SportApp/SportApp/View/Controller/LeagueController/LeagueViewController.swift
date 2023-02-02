//
//  LeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit

class LeagueViewController: UIViewController{
    
    @IBOutlet weak var leagueTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNibFile()
        leagueTable.delegate = self
        leagueTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func configurationNibFile(){
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        
        leagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
    
}

extension LeagueViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Leagues"
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
