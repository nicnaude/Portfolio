//
//  MenuCell.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 09/05/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    @IBOutlet weak var cellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
