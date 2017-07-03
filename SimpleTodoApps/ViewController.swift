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
        
        if UserDefaults.standard.object(forKey: "todoArray") != nil {
            todoArray = UserDefaults.standard.object(forKey: "todoArray") as! [String]
        }
        
        // テーブルを更新
        table.reloadData()
    }
    
    // テキストフィールドに入力された後に、enterを押されたら発動
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
        return true
    }
    
    // MARK: - Table関連
    
    // 選択されたテーブル
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count = Int(indexPath.row)
        
        // 画面遷移
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let editVC:EditViewController = segue.destination as! EditViewController
            
            // 選択されたセルの番号をEditに渡す
            editVC.selectedNumber = count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = todoArray[indexPath.row]
        
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

