//
//  ViewController.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/10.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // オフィスの情報を格納する配列
    var officeList = [Office]()
    
    let list = """
    [
        {
            "officeId": "0001",
            "officename": "オフィスA",
            "imgPath": "hogehoge.jpg",
            "spaceList": [
                {
                    "spaceId": "a1",
                    "spacename": "会議室",
                    "capacity": 20
                },
                {
                    "spaceId": "a2",
                    "spacename": "個室",
                    "capacity": 1
                },
            ]
        },
        {
            "officeId": "0002",
            "officename": "オフィスB",
            "imgPath": "fugafuge.jpg",
            "spaceList": [
                {
                    "spaceId": "b1",
                    "spacename": "ミーティングルーム",
                    "capacity": 6
                }
            ]
        }
    ]
    """.data(using: .utf8)!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let result = try JSONDecoder().decode([Office].self, from: list)
            // リストに追加
            self.officeList.append(contentsOf: result)
            print("## success!\n\(officeList)")
        } catch let error {
            print("## error!\n\(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

