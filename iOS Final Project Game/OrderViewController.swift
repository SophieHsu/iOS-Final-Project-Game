//
//  OrderViewController.swift
//  iOS-Game
//
//  Created by erin on 2017/5/21.
//  Copyright © 2017年 Erin Zhang. All rights reserved.
//

import UIKit
import SceneKit

var firstUserNmuber : Int = 0
var countNumber : Int = 5
var playerPieceArray: [SCNNode] = []
var orderArray: Array<Int> = []
var brickHArray = Array(repeating: Array(repeating: 0, count: 10), count: 10)

class OrderViewController: UIViewController {
    

    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StartViewController"){
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
        setupPlayerPieces()
        for name in userNameArray {
            print(name)
        }
        for node in playerPieceArray{
            print("name = ", node.name!)
            print("position = ", node.position)
        }
        
        // Do any additional setup after loading the view.
    }

    func setupPlayerPieces(){
        for i in 0...3 {
            var geometry:SCNGeometry
            geometry = SCNCone(topRadius: 0.0, bottomRadius: 3.5, height: 7.0)
            if (colorArray[i] == "blue"){
                print("setupPieces : blue")
                geometry.firstMaterial?.diffuse.contents = UIColor.blue
            }else if (colorArray[i] == "yellow"){
                print("setupPieces : yellow")
                geometry.firstMaterial?.diffuse.contents = UIColor.yellow
            }else if (colorArray[i] == "red"){
                print("setupPieces : red")
                geometry.firstMaterial?.diffuse.contents = UIColor.red
            }else if (colorArray[i] == "green"){
                print("setupPieces : green")
                geometry.firstMaterial?.diffuse.contents = UIColor.green
            }
            var geometryNode = SCNNode(geometry: geometry)
            geometryNode.name = userNameArray[i]
            
            if (colorArray[i] == "blue"){
                geometryNode.position = SCNVector3(x: 3.6+14.0, y: 3.5, z: 3.6+14.0)
            }else if (colorArray[i] == "yellow"){
                geometryNode.position = SCNVector3(x: 3.6+14.0, y: 3.5, z: 3.6-21.0)
            }else if (colorArray[i] == "red"){
                geometryNode.position = SCNVector3(x: 3.6-21.0, y: 3.5, z: 3.6+14.0)
            }else if (colorArray[i] == "green"){
                geometryNode.position = SCNVector3(x: 3.6-21.0, y: 3.5, z: 3.6-21.0)
            }
            
            geometryNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
            geometryNode.physicsBody?.isAffectedByGravity = true
            playerPieceArray.append(geometryNode)
            print("in")
            print(geometryNode.name!)
        }
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
