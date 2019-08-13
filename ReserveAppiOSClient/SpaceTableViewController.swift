//
//  SpaceTableViewController.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/12.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class SpaceTableViewController: UITableViewController {
    
    // オフィスに所属するスペースの情報を格納する配列
    var spaceList = [Space]()
    
    // オフィス名
    var officename: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let officename = officename {
            navigationItem.title = officename
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spaceList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "spaceCell", for: indexPath) as? SpaceTableViewCell else {
            return UITableViewCell()
        }
        
        // スペースのデータを取得
        let spaceData = spaceList[indexPath.row]
        
        // スペースのデータを設定
        cell.spaceData = spaceData
        
        // スペースの名前を設定
        cell.spaceNameLabel.text = spaceData.name

        return cell
    }
    
    // スペースのセルをタップして次の画面に遷移する前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? SpaceTableViewCell {
            if let spaceViewController = segue.destination as? SpaceViewController {
                // スペースの情報を設定する
                if let spaceData = cell.spaceData {
                    spaceViewController.spaceData = spaceData
                }
            }
        }
    }

}
