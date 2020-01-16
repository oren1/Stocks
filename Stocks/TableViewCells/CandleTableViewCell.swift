//
//  CandleTableViewCell.swift
//  Stocks
//
//  Created by oren shalev on 15/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import UIKit

class CandleTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
