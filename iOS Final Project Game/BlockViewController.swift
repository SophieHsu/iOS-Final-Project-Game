//
//  BlockViewController.swift
//  iOS Final Project Game
//
//  Created by erin on 2017/6/12.
//  Copyright © 2017年 Sophie Hsu. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var result: UILabel!
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
        if (tempNumber < 0){
            result.text = "error"
            print("pick error!")
        }else{
            result.text = "\(tempNumber)"
        }
        print(tempNumber)
        
    }
    

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DiceViewController"){
            show(vc,sender: self)
        }
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
