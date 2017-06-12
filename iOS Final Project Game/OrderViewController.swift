//
//  OrderViewController.swift
//  iOS-Game
//
//  Created by erin on 2017/5/21.
//  Copyright © 2017年 Erin Zhang. All rights reserved.
//

import UIKit

var firstUserNmuber : Int = 0

var orderArray: Array<Int> = []
class OrderViewController: UIViewController {
    

    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController"){
            show(vc,sender: self)
        }
    }
    
    @IBAction func BlueButton(_ sender: UIButton) {
        print("blue")
        firstUserNmuber = 0
    }
    
    @IBAction func YellowButton(_ sender: UIButton) {
        print("Yellow")
        firstUserNmuber = 1
    }
    
    @IBAction func RedButton(_ sender: UIButton) {
        print("Red")
        firstUserNmuber = 2
    }

    @IBAction func GreenButton(_ sender: UIButton) {
        print("green")
        firstUserNmuber = 3
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        for name in userNameArray {
            print(name)
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
