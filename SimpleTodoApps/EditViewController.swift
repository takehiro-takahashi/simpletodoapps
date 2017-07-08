//
//  EditViewController.swift
//  SimpleTodoApps
//
//  Created by 高橋岳宏 on 2017/07/03.
//  Copyright © 2017年 takehiro. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {
    
    // 選択されたセルの番号を取得する変数
    var selectedNumber:Int = 0
    
    var todoArray = [String]()
    
    // 背景画像
    @IBOutlet var backImageView: UIImageView!
    
    // テキストを表示するエリア
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // todoArrayアプリ内から選択されたセルの行を取得する
        if UserDefaults.standard.object(forKey: "todoArray") != nil {
            todoArray = UserDefaults.standard.object(forKey: "todoArray") as! [String]
            
            // 前の画面で選択された番号の文字を取り出し、テキストビューに反映
            textView.text = todoArray[selectedNumber]
        }
        
        if UserDefaults.standard.object(forKey: "imageTag") != nil {
            let imageTag = UserDefaults.standard.string(forKey: "imageTag")
            
            backImageView.image = UIImage(named: imageTag! + ".jpg")
        }
    }
    
    // 保存ボタンを押された時の処理
    @IBAction func save(_ sender: Any) {
        // 正規表現で、改行文字を空白文字に変換する
        textView.text! = textView.text!.replacingOccurrences(of: "\r\n|\n", with: "", options: NSString.CompareOptions.regularExpression, range: nil)
        
        // textViewの中身が殻だった場合、削除
        if textView.text! == "" {
            todoArray.remove(at: selectedNumber)
            UserDefaults.standard.set(todoArray, forKey: "todoArray")
            self.navigationController?.popViewController(animated: true)
            return
        }
        if textView.text != todoArray[selectedNumber] {
            todoArray[selectedNumber] = textView.text
            UserDefaults.standard.set(todoArray, forKey: "todoArray")
            
            if UserDefaults.standard.object(forKey: "todoArray") != nil {
                todoArray = UserDefaults.standard.object(forKey: "todoArray") as! [String]
            }
        }
        
        // 保存ボタンを押されたタイミングでキーボードを閉じる
        textView.resignFirstResponder()
    }
    
    // 削除ボタンを押された時の処理
    @IBAction func deleteTodo(_ sender: Any) {
        // 選択されたセルの行を削除
        todoArray.remove(at: selectedNumber)
        
        // 削除した内容をUserDefaultに保存
        UserDefaults.standard.set(todoArray, forKey: "todoArray")
        
        // セルが存在しないため、一覧ページに戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // テキストビュー以外の箇所をタッチされたらキーボードを閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            // キーボードを閉じる
            textView.resignFirstResponder()
        }
    }
    

    // メモリーの解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
