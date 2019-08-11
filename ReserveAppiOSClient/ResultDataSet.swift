//
//  OfficeData.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/10.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import Foundation

// オフィスのデータを表現する構造体
struct Office: Codable {
    var id: String
    var name: String
    var img: String?
    var spaceList: [Space]
    
    private enum CodingKeys: String, CodingKey {
        case id = "officeId"
        case name = "officename"
        case img = "imgPath"
        case spaceList = "spaceList"
    }
}

// スペースのデータを表現する構造体
struct Space: Codable {
    var id: String
    var name: String
    var capacity: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "spaceId"
        case name = "spacename"
        case capacity
    }
}
