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
        
    }
    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OrderViewController"){
            show(vc,sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_dice_to_block"{
            let vc = segue.destination as! BlockViewController
            vc.receiveNumber = sendNumber
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        for name in userNameArray {
            print(name)
        }
        for level in userLevelArray {
            print(level)
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
