//
//  QuestionViewController.swift
//  WordList
//
//  Created by 吉川莉央 on 2018/04/02.
//  Copyright © 2018年 RioYoshikawa. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false//回答したか次の問題に行くかの判定
    var wordArray: [Dictionary<String, String>] = []//Userdefaultから取る配列
    var shuffleWordArray: [Dictionary<String, String>] = []//シャッフルされた配列
    var nowNumber: Int = 0//現在の回答数
    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
    }
    
    //viewが現れた時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordArray = saveData.array(forKey: "WORD") as! [Dictionary<String,String>]
        //問題をシャッフルする
        shuffle()
        questionLabel.text = shuffleWordArray[nowNumber]["english"]
    }
    
    func shuffle(){
        while wordArray.count > 0{
            let index = Int(arc4random()) % wordArray.count
            shuffleWordArray.append(wordArray[index])
            wordArray.remove(at: index)
        }
    }
    
    @IBAction func nextButtonTapped(){
        //回答したか
        if isAnswered{
            //次の問題へ
            nowNumber += 1
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffleWordArray.count {
                //次の問題を表示
                questionLabel.text = shuffleWordArray[nowNumber]["english"]
                //isAnsweredをfalseにする
                isAnswered = false
                //ボタンのタイトルを変更する
                nextButton.setTitle("答えを表示", for: .normal)
            }else{
                // これ以上表示する問題がないのでFinishビューに遷移
                self.performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        }else{
            //答えを表示する
            answerLabel.text = shuffleWordArray[nowNumber]["japanese"]
            //isAnsweredをtrueにする
            isAnswered = true
            //ボタンのタイトルをオンにする
            nextButton.setTitle("次へ",for: .normal)
        }
    }
    
}
