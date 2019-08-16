//
//  SpaceViewController.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/13.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {
    
    // スペースの情報を格納する定数
    var spaceData:Space?
    
    // リクエストのベースURL
    var baseUrl: String = "https://reserve-tumolink.herokuapp.com"
    
    // APIのパス
    var apiPath: String = "/api/periodDataOfCurrentDay?spaceId="

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let spaceData = spaceData else {
            return
        }
        
        // ナビゲーションバーのタイトルにスペース名を設定
        navigationItem.title = spaceData.name
        
        // リクエストURLを作成する
        let requestUrl = baseUrl + apiPath + spaceData.id
        
        // APIをリクエストする
        request(requestUrl: requestUrl)
    }
    
    // APIをリクエストする関数
    func request(requestUrl: String) {
        // URL生成
        guard let url = URL(string: requestUrl) else {
            // URL生成失敗
            return
        }
        // リクエスト生成
        let request = URLRequest(url: url)
        // APIをコールしてデータを格納する
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data:Data?, response:URLResponse?, error:Error?) in
            // 通信完了後の処理
            // エラーチェック
            guard error == nil else {
                // エラー表示
                let alert = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                // UIに関する処理はメインスレッドで行う
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            // JSONで格納されたデータをパースして格納する
            guard let data = data else {
                // データなし
                return
            }
            // パース処理
            do {
                let result = try JSONDecoder().decode(Reservation.self, from: data)
                print("## success!\n\(result.periods)")
                // リストに追加
                //self.officeList.append(contentsOf: result)
            } catch let error {
                print("## error!\n\(error)")
            }
        }
        
        // 通信開始
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
