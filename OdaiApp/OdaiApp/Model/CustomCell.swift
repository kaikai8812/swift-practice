//
//  CustomCell.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
