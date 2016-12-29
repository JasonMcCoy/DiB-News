//
//  ArticleCell.swift
//  DiB News
//
//  Created by Jason McCoy on 09/6/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}