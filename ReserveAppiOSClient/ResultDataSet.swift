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

// スペースの空き状況のデータを表現するクラス
class Reservation: Codable {
    var periods: [Period] = [Period]()
    
    required init(from decoder: Decoder) throws {
        // デコードのためのコンテナを取得
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // コンテナ内のキーを取得
        // キーが文字列であるため、数値の照準でソートも行う
        let keys = container.allKeys.sorted {
            Int($0.rawValue)! < Int($1.rawValue)!
        }
        // キーを使用して結果を一件づつ取り出す
        for key in keys {
            // デコード処理
            let period = try container.decode(Period.self, forKey: key)
            // デコード処理ができたら配列に追加
            periods.append(period)
        }
    }
    
    // Codableプロトコルに準拠するために記述
    func encode(to encoder: Encoder) throws {
        // レスポンスを解析するだけなので実装不要
    }
    
    private enum CodingKeys: String, CodingKey {
        case period1 = "1"
        case period2 = "2"
        case period3 = "3"
        case period4 = "4"
        case period5 = "5"
        case period6 = "6"
        case period7 = "7"
        case period8 = "8"
    }
}

// 一つのコマ（時間帯）のデータを表現する構造体
struct Period: Codable {
    var num: Int
    var startTime: Int
    var labelText: String
    var startTimeText: String
    var endTimeText: String
    var availability: Bool
    var isSelf: Bool
    
    private enum CodingKeys: String, CodingKey {
        case num
        case startTime
        case labelText = "periodLabelString"
        case startTimeText = "startTimeString"
        case endTimeText = "endTimeString"
        case availability
        case isSelf
    }
}
