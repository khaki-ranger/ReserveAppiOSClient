//
//  OfficeTableViewCell.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/11.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class OfficeTableViewCell: UITableViewCell {

    // オフィス名
    @IBOutlet weak var officeNameLabel: UILabel!
    // オフィスのサムネイル画像
    @IBOutlet weak var officeImageView: UIImageView!
    // 所属するスペースのリストを空の配列で宣言
    // 遷移先の画面で利用する
    var spaceList: [Space] = [Space]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 通信でエラーが発生した場合のためにセル再利用時に行う処理
    override func prepareForReuse() {
        // 元々入っている情報を再利用時にクリア
        officeImageView.image = nil
    }

}
