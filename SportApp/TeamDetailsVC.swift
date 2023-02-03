//
//  TeamDetailsVC.swift
//  SportApp
//
//  Created by Fatma on 03/02/2023.
//

import UIKit

class TeamDetailsVC: UIViewController {

    @IBOutlet weak var teamImageFrame: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamImageFrame.layer.masksToBounds = true
        teamImageFrame.layer.cornerRadius = 20
        
    }
    

    
}
