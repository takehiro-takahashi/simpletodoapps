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
    }
    
    // テキストビュー以外の箇所をタッチされたらキーボードを閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            // キーボードを閉じる
            textView.resignFirstResponder()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
