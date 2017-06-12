//
//  BlockViewController.swift
//  iOS Final Project Game
//
//  Created by erin on 2017/6/12.
//  Copyright © 2017年 Sophie Hsu. All rights reserved.
//

import UIKit

var tempBool1 = false
var tempBool2 = false

class BlockViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var result: UILabel!
    var temp = countNumber
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    let block1Array = [0,1,2,3,4,5,6,7,8,9,10]
    var tempNumber = Int()
    @IBOutlet weak var getNumber: UILabel!
    var receiveNumber : Int? = nil
    var ans = 0
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return block1Array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return "\(block1Array[row])"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempNumber = ans - block1Array[row]
        firstBlockArray[temp] = block1Array[row]
        print("firstBlockArray[\(temp)] =  \(firstBlockArray[temp])")
        if (tempNumber < 0){
            result.text = "error"
            print("pick error!")
        }else{
            secondBlockArray[temp] = tempNumber
            print("secondBlockArray[\(temp)] =  \(secondBlockArray[temp])")
            result.text = "\(tempNumber)"
        }
    }
    

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DiceViewController"){
            show(vc,sender: self)
        }
    }
    
    @IBAction func BlockRBtn(_ sender: UIButton) {
        print("\(secondBlockArray[temp])")
        tempBool1 = true

    }
    @IBAction func BlockLBtn(_ sender: UIButton) {
        print("\(firstBlockArray[temp])")
        tempBool2 = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let number = receiveNumber{
            getNumber.text = "\(number)"
            ans = number
            print(number)
        }else{
            print("no data")
        }

        
        for name in userNameArray {
            print(name)
        }
        for dice in diceNumberArray {
            print(dice)
        }
        
        
        if (temp < 0){
            temp = 0
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userNameArray[temp], forKey: "name")
        userDefaults.set(colorArray[temp], forKey: "color")
        userDefaults.set(userLevelArray[temp], forKey: "Level")
        userDefaults.set(diceNumberArray[temp], forKey: "diceNumber")
        userDefaults.set(firstBlockArray[temp], forKey: "firstBlock")
        userDefaults.set(secondBlockArray[temp], forKey: "secondBlock")
        
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
            x: fullScreenSize.width * 0.2,
            y: fullScreenSize.height * 0.15)
        self.view.addSubview(myImageView)
        // Do any additional setup after loading the view.

        
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
