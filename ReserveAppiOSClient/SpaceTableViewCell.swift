//
//  SpaceTableViewCell.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/13.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {

    // スペース名
    @IBOutlet weak var spaceNameLabel: UILabel!
    
    // スペースの情報
    // 遷移先の画面で利用する
    var spaceData:Space?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
