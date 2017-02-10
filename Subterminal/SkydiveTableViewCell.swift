//
//  SkydiveTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var dropzoneLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var aircraftLabel: UILabel!
    //@IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var countLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
