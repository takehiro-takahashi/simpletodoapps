//
//  SettingViewController.swift
//  SimpleTodoApps
//
//  Created by 高橋岳宏 on 2017/07/03.
//  Copyright © 2017年 takehiro. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // 背景画像
    @IBOutlet var backImageView: UIImageView!
    
    // スクロールビュー
    @IBOutlet var scrollView: UIScrollView!
    
    var vc = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        for i in 0..<10 {
            let button:UIButton = UIButton()
            button.tag = i
            button.frame = CGRect(x: (i*80), y: 0, width: 80, height: 80)
            let buttonImage:UIImage = UIImage(named: String(i) + ".jpg")!
            button.setImage(buttonImage, for: UIControlState.normal)
            button.addTarget(self, action: #selector(selectedImage), for: .touchUpInside)
            vc.addSubview(button)
        }
        
        scrollView.addSubview(vc)
        scrollView.contentSize = vc.bounds.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 一覧画面から、背景を変更ボタンを押された際に、一覧画面で使われている背景を設定画面で表示
        if UserDefaults.standard.object(forKey: "imageTag") != nil {
            let imageTag = UserDefaults.standard.string(forKey: "imageTag")
            backImageView.image = UIImage(named: imageTag! + ".jpg")
        }
    }
    
    func selectedImage(sender: UIButton) {
        // 画像をUIImageViewに反映する
        backImageView.image = UIImage(named: String(sender.tag) + ".jpg")
        
        // そのButtonのtag情報をアプリ内に保存する
        UserDefaults.standard.set(String(sender.tag), forKey: "imageTag")
    }
    
    
    // 戻る
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
