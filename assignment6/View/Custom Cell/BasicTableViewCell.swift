//
//  BasicTableViewCell.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/25/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basicImage: UIImageView!
    @IBOutlet weak var basicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
