//
//  OfficeTableViewController.swift
//  ReserveAppiOSClient
//
//  Created by 寺島 洋平 on 2019/08/11.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

class OfficeTableViewController: UITableViewController {
    
    // オフィスとスペースの情報を格納する配列
    var officeList = [Office]()
    
    // オフィスのサムネイル画像データをキャッシュする
    var imageCache = NSCache<AnyObject, UIImage>()
    
    // リクエストのベースURL
    var baseUrl: String = "https://reserve-tumolink.herokuapp.com"
    
    // APIのパス
    var apiPath: String = "/api/officespacelist"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 保持しているデータを一旦削除
        officeList.removeAll()
        
        // リクエストURLを作成する
        let requestUrl = baseUrl + apiPath
        
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
                let result = try JSONDecoder().decode([Office].self, from: data)
                // リストに追加
                self.officeList.append(contentsOf: result)
                print("## success!\n\(self.officeList)")
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

    // MARK: - Table view data source

    // テーブルのセクション数を取得
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // セクション内のオフィスの数を取得
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return officeList.count
    }

    // セクション内のオフィスの数を取得
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "officeCell", for: indexPath) as? OfficeTableViewCell else {
            return UITableViewCell()
        }
        
        // オフィスのデータを取得
        let officeData = officeList[indexPath.row]
        
        // オフィスの名前を設定
        cell.officeNameLabel.text = officeData.name
        
        // オフィスのサムネイル画像を設定
        // すでにセルに設定されている画像と同じかどうかチェックする
        // 画像がまだ設定されていない場合に処理を行う
        guard let officeImageUrl = officeData.img else {
            // 画像なし
            return cell
        }
        
        // 画像パスが相対パスだった場合、絶対パスに変換する処理
        // これから実装する
        
        // キャッシュの画像を取り出す
        if let cacheImage = imageCache.object(forKey: officeImageUrl as AnyObject) {
            // キャッシュの画像を設定
            cell.officeImageView.image = cacheImage
            return cell
        }
        // キャッシュの画像がないためダウンロードする
        guard let url = URL(string: officeImageUrl) else {
            // urlが生成できなかった
            return cell
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else {
                // エラー発生
                return
            }
            guard let data = data else {
                // データが存在しない
                return
            }
            guard let image = UIImage(data: data) else {
                // imageが生成できなかった
                return
            }
            // ダウンロードした画像をキャッシュに登録しておく
            self.imageCache.setObject(image, forKey: officeImageUrl as AnyObject)
            // 画像はメインスレッド上で設定する
            DispatchQueue.main.async {
                cell.officeImageView.image = image
            }
        }
        
        // 画像の読み込み処理開始
        task.resume()

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
