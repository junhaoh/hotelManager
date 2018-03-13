//
//  DisplayCell.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/1/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit

class DisplayCell: UITableViewCell {
    
    
    @IBOutlet weak var customTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
