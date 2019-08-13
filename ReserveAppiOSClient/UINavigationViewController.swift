//
//  UINavigationViewController.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/13.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class UINavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // ナビゲーションバーの背景色
        navigationBar.barTintColor = UIColor(hex: "D7092F")
        
        // ナビゲーションバーのアイテムの色
        navigationBar.tintColor = .white
        
        // ナビゲーションバーのテキストの色
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
