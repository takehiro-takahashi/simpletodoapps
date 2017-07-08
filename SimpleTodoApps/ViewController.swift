//
//  ViewController.swift
//  SimpleTodoApps
//
//  Created by 高橋岳宏 on 2017/07/03.
//  Copyright © 2017年 takehiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // ToDo入力フィールド
    @IBOutlet var textField: UITextField!
    
    // table紐付け
    @IBOutlet var table: UITableView!
    
    // テーブルのセルに表示するラベル
    var label:UILabel = UILabel()
    
    // todoを入れる配列
    var todoArray = [String]()
    
    // 選択されたセルの番号を取得する
    var count:Int = 0
    
    // キーボードの状態（閉じているか開いているか）False -> 閉じている
    var keyboardFlag: Bool = false
    
    // 背景画像
    @IBOutlet var backImageView: UIImageView!
    
    // タップするとキーボードを閉じるボタン
    @IBOutlet var TapCloseKeyBoard: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tebleのdelegate設定
        table.delegate = self
        table.dataSource = self
        
        // textFieldのdelegate設定
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // キーボードが出ていない時は隠す
        TapCloseKeyBoard.isHidden = true
        
        if UserDefaults.standard.object(forKey: "todoArray") != nil {
            todoArray = UserDefaults.standard.object(forKey: "todoArray") as! [String]
        }
        
        if UserDefaults.standard.object(forKey: "imageTag") != nil {
            let imageTag = UserDefaults.standard.string(forKey: "imageTag")
            
            backImageView.image = UIImage(named: imageTag! + ".jpg")
        }
        
        // テーブルを更新
        table.reloadData()
    }
    
    // MARK: - Keyboard
    
    // textFieldのフォーカスがOnになったらタップボタンを表示にする
    func textFieldDidBeginEditing(_ textField: UITextField) {
        TapCloseKeyBoard.isHidden = false
    }
    
    // textFieldのフォーカスが離れたらタップボタンを非表示にする
    func textFieldDidEndEditing(_ textField: UITextField) {
        TapCloseKeyBoard.isHidden = true
    }
    
    // タップされるとキーボードを閉じる
    @IBAction func tapCloseKeyBoardButton(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    
    // テキストフィールドに入力された後に、enterを押されたら発動
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 何も無ければfalse
        if textField.text!.isEmpty {
            return false
        }
        
        // 空白文字を削除する
        textField.text! = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if textField.text! != "" {
            // todo配列の中にTextFieldに入力されたTodoを入れる
            todoArray.append(textField.text!)
            
            UserDefaults.standard.set(todoArray, forKey: "todoArray")
            
            if UserDefaults.standard.object(forKey: "todoArray") != nil {
                todoArray = UserDefaults.standard.object(forKey: "todoArray") as! [String]
                
                textField.text = ""
                table.reloadData()
            }
            
            // 改行ボタンが押されたらキーボードを閉じる
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: - Table関連
    
    // 選択されたテーブル
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count = Int(indexPath.row)
        
        // 画面遷移
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    // セルを選択された時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let editVC:EditViewController = segue.destination as! EditViewController
            
            // 選択されたセルの番号をEditに渡す
            editVC.selectedNumber = count
        }
    }
    
    // セルをいくつ返すのか。通常は一つ。
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セルをいくつ返すのか。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todoArrayに入っているtodoの数だけセルを返す
        return todoArray.count
    }
    
    // 各セルに対して、データを表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.layer.cornerRadius = 15.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = todoArray[indexPath.row]
        
        return cell
    }
    
    // セルをスライドしたときの処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // todoArrayの選択されたセルの番号の配列に入っている文字を削除する
            todoArray.remove(at: indexPath.row)
            
            // 配列をアプリ内へ保存する
            UserDefaults.standard.set(todoArray, forKey: "todoArray")
            
            // tableのデリゲートメソッドを呼ぶ
            table.reloadData()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

