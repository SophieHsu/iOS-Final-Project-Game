//
//  BlockViewController.swift
//  iOS Final Project Game
//
//  Created by erin on 2017/6/12.
//  Copyright © 2017年 Sophie Hsu. All rights reserved.
//

import UIKit

var indexNumberBoolR = false
var indexNumberBoolL = false

class BlockViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var result: UILabel!
    var indexNumber = countNumber
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    var indexNumberNumber = Int()
    
    @IBOutlet weak var getNumber: UILabel!
    var receiveNumber : Int? = nil
    var ans = 0
    
    //var block1Array = [0,1,2,3,4,5,6,7,8,9,10]
    var block1Array = [Int]()
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return block1Array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return "\(block1Array[row])"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexNumberNumber = ans - block1Array[row]
        firstBlockArray[indexNumber] = block1Array[row]
        print("firstBlockArray[\(indexNumber)] =  \(firstBlockArray[indexNumber])")
        if (indexNumberNumber < 0){
            result.text = "error"
            print("pick error!")
        }else{
            secondBlockArray[indexNumber] = indexNumberNumber
            print("secondBlockArray[\(indexNumber)] =  \(secondBlockArray[indexNumber])")
            result.text = "\(indexNumberNumber)"
        }
    }
    

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DiceViewController"){
            show(vc,sender: self)
        }
    }
    
    @IBAction func BlockRBtn(_ sender: UIButton) {
        print("\(secondBlockArray[indexNumber])!!!")
        print("indexNumberBoolR = true")
        indexNumberBoolR = true

    }
    @IBAction func BlockLBtn(_ sender: UIButton) {
        print("\(firstBlockArray[indexNumber])!!!")
        print("indexNumberBoolL = true")
        indexNumberBoolL = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if receiveNumber != nil{
            if let number = receiveNumber{
                getNumber.text = "\(number)"
                ans = number
                print("getNumber: \(number)")
                for i in 0..<ans+1{
                    block1Array.append(i)
                }
                
            }else{
                print("no data")
            }
        }
        

        
        for name in userNameArray {
            print(name)
        }
        for dice in diceNumberArray {
            print(dice)
        }
        
        
        if (indexNumber < 4){
            indexNumber = indexNumber + 0
        }else if (indexNumber == 4){
            indexNumber = 0
        }else{
            indexNumber = countNumber
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userNameArray[indexNumber], forKey: "name")
        userDefaults.set(colorArray[indexNumber], forKey: "color")
        userDefaults.set(userLevelArray[indexNumber], forKey: "Level")
        userDefaults.set(diceNumberArray[indexNumber], forKey: "diceNumber")
        userDefaults.set(firstBlockArray[indexNumber], forKey: "firstBlock")
        userDefaults.set(secondBlockArray[indexNumber], forKey: "secondBlock")
        
        userDefaults.synchronize()
        
        let color = userDefaults.object(forKey: "color")
        // 使用 UIImageView(frame:) 建立一個 UIImageView
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
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
            x: fullScreenSize.width * 0.2,
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
