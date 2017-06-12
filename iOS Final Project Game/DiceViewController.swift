//
//  DiceViewController.swift
//  iOS Final Project Game
//
//  Created by erin on 2017/6/12.
//  Copyright © 2017年 Sophie Hsu. All rights reserved.
//

import UIKit
import Foundation



class DiceViewController: UIViewController {
    @IBOutlet weak var diceNumber: UILabel!
    var sendNumber: Int? = 0

    
    @IBAction func diceButton(_ sender: Any) {
        let randnumber = arc4random_uniform(10) + 1
        sendNumber = Int(randnumber)
        diceNumber.text = "\(randnumber)"
        diceNumberArray[countNumber] = sendNumber!
        print("diceNumberArray[\(countNumber)] = \(diceNumberArray[countNumber])")
        
        
        
    }
    
    @IBAction func NextBtn(_ sender: UIBarButtonItem) {
//        countNumber = countNumber + 1
    }
    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController"){
            show(vc,sender: self)
//            countNumber = countNumber + 1
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_dice_to_block"{
            let vc = segue.destination as! BlockViewController
            vc.receiveNumber = sendNumber
        }
    }

    
    @IBOutlet weak var userColorImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for name in userNameArray {
            print(name)
        }
        for dice in diceNumberArray {
            print(dice)
        }
        
        if (countNumber < 4){
            countNumber = countNumber + 0
            
        }else if(countNumber == 4){
            countNumber = 0
        }else{
            countNumber = firstUserNmuber 
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userNameArray[countNumber], forKey: "name")
        userDefaults.set(colorArray[countNumber], forKey: "color")
        userDefaults.set(userLevelArray[countNumber], forKey: "Level")
        userDefaults.set(diceNumberArray[countNumber], forKey: "diceNumber")
        userDefaults.set(firstBlockArray[countNumber], forKey: "firstBlock")
        userDefaults.set(secondBlockArray[countNumber], forKey: "secondBlock")
        
        userDefaults.synchronize()
        
        let color = userDefaults.object(forKey: "color")
        // 使用 UIImageView(frame:) 建立一個 UIImageView
        let myImageView = UIImageView(
            frame: CGRect(
                x: 0, y: 0, width: 100, height: 100))
        
        // 使用 UIImage(named:) 放置圖片檔案
        if (color as! String == "blue"){
            myImageView.image = UIImage(named: "photo_blue")
        }else if (color as! String == "yellow"){
            myImageView.image = UIImage(named: "photo_yellow")
        }else if (color as! String == "red"){
            myImageView.image = UIImage(named: "photo_red")
        }else if (color as! String == "green"){
            myImageView.image = UIImage(named: "photo_green")
        }
        
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        // 設置新的位置並放入畫面中
        myImageView.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.15)
        self.view.addSubview(myImageView)
        // Do any additional setup after loading the view.
        
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
