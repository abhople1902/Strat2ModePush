//
//  MainFeedCustomTableViewCell.swift
//  Downforce
//
//  Created by Ayush Bhople on 21/03/25.
//

import UIKit

class MainFeedCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
