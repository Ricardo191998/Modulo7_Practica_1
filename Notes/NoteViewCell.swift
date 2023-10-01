//
//  NoteViewCell.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 23/09/23.
//

import UIKit

class NoteViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
