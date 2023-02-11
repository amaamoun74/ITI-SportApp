//
//  LeagueTableViewCell.swift
//  SportApp
//
//  Created by ahmed on 01/02/2023.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIButton!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    weak var customDelegate: (CustomViewDelegate)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = cellImage.frame.size.width / 2
        cellImage.clipsToBounds = true
        cellImage.layer.masksToBounds = true
        cellImage.layer.borderWidth = 1.5
        cellImage.layer.borderColor = UIColor.white.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func navigate(_ sender: Any) {
        customDelegate?.navigateToNextScene()
    }
}
