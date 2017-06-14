//
//  GameViewController.swift
//  iOS Final Project Game
//
//  Created by Sophie Hsu on 30/05/2017.
//  Copyright © 2017 Sophie Hsu. All rights reserved.
//

import UIKit
import QuartzCore
import SpriteKit
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate, SKSceneDelegate, SCNPhysicsContactDelegate{
    var scnView: SCNView!
    var scnScene: SCNScene!
    var skScene: SKScene!
    var cameraNode: SCNNode!
    var spawnTime:TimeInterval = 0
    var geometry:SCNGeometry!
    var geometryNode:SCNNode!
    var indexNumber = countNumber
    
    
//  Chess piece
    
//  SKScene Nodes
    let up = SKSpriteNode(imageNamed:"up")
    let down = SKSpriteNode(imageNamed:"down")
    let upRight = SKSpriteNode(imageNamed:"upRight")
    let upLeft = SKSpriteNode(imageNamed:"upLeft")
    let downRight = SKSpriteNode(imageNamed:"downRight")
    let downLeft = SKSpriteNode(imageNamed:"downLeft")
    let ok = SKSpriteNode(imageNamed:"ok")
    let turn = SKSpriteNode(imageNamed:"turn")
    let back = SKSpriteNode(imageNamed:"back")
//  Variables
    var TouchState = ""
    var brickNum = 2
    var turnState = 3
    var pieceBool = false
    var color: String? = nil
    var block :Int = 0
    
//  Array for brick height
    var brickHArray = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (indexNumber < 0){
            indexNumber = 0
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userNameArray[indexNumber], forKey: "name")
        userDefaults.set(colorArray[indexNumber], forKey: "color")
        userDefaults.set(userLevelArray[indexNumber], forKey: "Level")
        userDefaults.set(diceNumberArray[indexNumber], forKey: "diceNumber")
        userDefaults.set(firstBlockArray[indexNumber], forKey: "firstBlock")
        userDefaults.set(secondBlockArray[indexNumber], forKey: "secondBlock")
        
        userDefaults.synchronize()  // update data
        
        color = (userDefaults.object(forKey: "color") as! String)
        let level = userDefaults.integer(forKey: "Level")
        
        // 使用 UIImageView(frame:) 建立一個 UIImageView
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let myLevelView = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        let myBlockView = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        
        myLevelView.text = "Current level: \(level)"
        
        // Block number
        if (indexNumberBoolL == true){
            print("indexNumberBoolL = true!")
            block = userDefaults.integer(forKey: "firstBlock")
            myBlockView.text = "Block length : \(block)"
            indexNumberBoolL = false
        }
        
        if (indexNumberBoolR == true){
            print("indexNumberBoolL = true!")
            block = userDefaults.integer(forKey: "secondBlock")
            myBlockView.text = "Block length : \(block)"
            indexNumberBoolR = false
        }
        
        // 3D view build
        setupView()
        setupControlBtn()
        setupScene()
        setupSKScene()
        setupCamera()
        setupPieces()
        spawnShape(length: Double(block))
        print(scnView.isUserInteractionEnabled)
        print(skScene.isUserInteractionEnabled)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        
        
        
        
        
        // 使用 UIImage(named:) 放置圖片檔案
        if (color == "blue"){
            myImageView.image = UIImage(named: "photo_blue")
        }else if (color == "yellow"){
            myImageView.image = UIImage(named: "photo_yellow")
        }else if (color == "red"){
            myImageView.image = UIImage(named: "photo_red")
        }else if (color == "green"){
            myImageView.image = UIImage(named: "photo_green")
        }
        
        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        // 設置新的位置並放入畫面中
        myImageView.center = CGPoint(
            x: fullScreenSize.width * 0.2,
            y: fullScreenSize.height * 0.15)
        self.view.addSubview(myImageView)
        
        myLevelView.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.15)
        self.view.addSubview(myLevelView)
        
        myBlockView.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.2)
        self.view.addSubview(myBlockView)


        
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // check what nodes are tapped
        var location = gestureRecognize.location(in: scnView)
        location.y = (1000-location.y)
        location.x = (location.x/768)*1000
        if self.up.contains(location) {
            TouchState = "up"
            print("up!")
        } else if self.down.contains(location) {
            TouchState = "down"
            print("down!")
        } else if self.upRight.contains(location) {
            TouchState = "upRight"
            print("upRight!")
        } else if self.upLeft.contains(location) {
            TouchState = "upLeft"
            print("upLeft!")
        } else if self.downRight.contains(location) {
            TouchState = "downRight"
            print("downRight!")
        } else if self.downLeft.contains(location) {
            TouchState = "downLeft"
            print("downLeft!")
        } else if self.ok.contains(location) {
            TouchState = "ok"
            print("ok!")
        } else if self.turn.contains(location) {
            TouchState = "turn"
            print("turn!")
        } else if self.back.contains(location) {
            TouchState = "back"
            print("back!")
        }else{
            TouchState = ""
        }
        if(pieceBool){
            movePiece(t: TouchState)
        }else{
            moveBrick(touch: TouchState)
        }
        //print(geometryNode.position)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.isUserInteractionEnabled = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
        var geometry:SCNGeometry
        geometry = SCNBox(width: 100.0, height: 0.0, length: 100.0, chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = UIImage.init(named: "base.jpg")
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 0, y: 0, z: 0)
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        geometryNode.physicsBody?.isAffectedByGravity = false
    }
    
    func setupSKScene(){
        skScene = SKScene(size: CGSize(width: 1000, height: 1000))
        skScene.isUserInteractionEnabled = true
        skScene.backgroundColor = UIColor.green
        skScene.addChild(up)
        skScene.addChild(down)
        skScene.addChild(upRight)
        skScene.addChild(upLeft)
        skScene.addChild(downRight)
        skScene.addChild(downLeft)
        skScene.addChild(ok)
        skScene.addChild(turn)
        skScene.addChild(back)
        scnView.overlaySKScene = skScene
    }
    
//    func collada2SCNNode(filepath:String) -> SCNNode {
//        var node = SCNNode()
//        let scene = SCNScene(named: filepath)
////        var nodeArray = scene!.rootNode.childNodes
//        
////        for childNode in nodeArray {
//            node.addChildNode(childNode as SCNNode)
////        }
//        return node
//    }
    
    func setupPieces(){
        geometry = SCNCone(topRadius: 0.0, bottomRadius: 3.5, height: 7.0)
        // 使用 UIColor change color
        
        if (colorArray[indexNumber] == "blue"){
            print("setupPieces : blue")
            geometry.firstMaterial?.diffuse.contents = UIColor.blue
        }else if (colorArray[indexNumber] == "yellow"){
            print("setupPieces : yellow")
            geometry.firstMaterial?.diffuse.contents = UIColor.yellow
        }else if (colorArray[indexNumber] == "red"){
            print("setupPieces : red")
            geometry.firstMaterial?.diffuse.contents = UIColor.red
        }else if (colorArray[indexNumber] == "green"){
            print("setupPieces : green")
            geometry.firstMaterial?.diffuse.contents = UIColor.green
        }
        
        
        
        geometryNode = SCNNode(geometry: geometry)
        geometryNode.name = "player1"
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 3.6+14.0, y: 3.5, z: 3.6+14.0)
        geometryNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        geometryNode.physicsBody?.isAffectedByGravity = true

        
        // Load the character.
//        let characterScene = SCNScene.init(url: "Assets.xcassets/queen.dae", options: [:])
//        let characterTopLevelNode = characterScene.RootNode.ChildNodes[0];
//        
//        scnScene.rootNode.addChildNode(characterTopLevelNode)
////        let myNode = collada2SCNNode(filepath: "Assets.xcassets/queen.dataset/queen.dae")
////        print(myNode)
//        let assetScene = SCNScene(named: "queen.dae")
////        let node = assetScene?.rootNode.childNode[0]
//        scnScene.rootNode.addChildNode(node)
        
    }
    
    func setupControlBtn(){
        up.size = CGSize(width: 60, height: 50)
        up.position = CGPoint(x: 80, y: 110)

        down.size = CGSize(width: 60, height: 50)
        down.position = CGPoint(x: 80, y: 50)

        upRight.size = CGSize(width: 60, height: 50)
        upRight.position = CGPoint(x: 950, y: 80)

        upLeft.size = CGSize(width: 60, height: 50)
        upLeft.position = CGPoint(x: 880, y: 110)

        downRight.size = CGSize(width: 60, height: 50)
        downRight.position = CGPoint(x: 880, y: 50)
        
        downLeft.size = CGSize(width: 60, height: 50)
        downLeft.position = CGPoint(x: 810, y: 80)

        ok.size = CGSize(width: 60, height: 50)
        ok.position = CGPoint(x: 150, y: 80)

        turn.size = CGSize(width: 60, height: 50)
        turn.position = CGPoint(x: 220, y: 80)
        
        back.size = CGSize(width: 60, height: 50)
        back.position = CGPoint(x: 740, y: 80)
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 80, z: 100)
        cameraNode.camera?.xFov = 60
        cameraNode.camera?.yFov  = 60
        cameraNode.camera?.zFar = 1000
        cameraNode.camera?.zNear = 0.01
        cameraNode.rotation = SCNVector4(1.0, 0.0, 0.0, -Float(M_PI_4)/2)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape(length: Double) {
        geometry = SCNBox(width: 7.0, height: 7.0, length: CGFloat(7.0*length), chamferRadius: 0.0)
        
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        if(length.truncatingRemainder(dividingBy: 2) != 0){
            geometryNode.position = SCNVector3(x: 3.6, y: 73.5, z: 3.6)
        }else{
            geometryNode.position = SCNVector3(x: 3.6, y: 73.5, z: 3.5)
            geometryNode.pivot = SCNMatrix4MakeTranslation(0, 0, 3.5)
        }
        geometryNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        geometryNode.physicsBody?.isAffectedByGravity = true
//        geometryNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, Float(M_PI_4))
//        let force = SCNVector3(x: 1, y: 1 , z: 1)
//        var position = SCNVector3(x: 1.0, y: 0.0, z: 0.0)
//        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
//        geometryNode.physicsBody?.clearAllForces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        moveBrick(touch: TouchState)
        print(geometryNode.position)
        
    }
    
    func movePiece(t: String){
        let piece = scnScene.rootNode.childNode(withName: "player1", recursively: false)
        if t == "upRight" {
//            print(brickHArray[(((piece?.position.x)!+35)/7)+1][((piece?.position.z+35)/7)])
//            print(brickHArray[(((piece?.position.x)!+35)/7)][((piece?.position.z+35)/7)])
            let i = Int(Int((piece?.position.x)!+35)/7)
            let j = Int(Int((piece?.position.z)!+35)/7)
            print(i, j, separator:" ", terminator:"")
            print(i+1, j, separator:" ", terminator:"")
            print("right gap = ", abs(Int(brickHArray[i+1][j] - brickHArray[i][j])))
            if (abs(Int(brickHArray[i+1][j] - brickHArray[i][j])) < 8 && i < 10 && j < 10 && i > 0 && j > 0){
                piece?.position.x += 7
                let temp = (Float(brickHArray[i+1][j] - brickHArray[i][j]))
                piece?.position.y += temp
            }
        } else if t == "upLeft" {
            let i = Int(Int((piece?.position.x)!+35)/7)
            let j = Int(Int((piece?.position.z)!+35)/7)
            print(i, j, separator:" ", terminator:"")
            print(i+1, j, separator:" ", terminator:"")
            print("up gap = ", abs(Int(brickHArray[i][j-1] - brickHArray[i][j])))
            if (abs(Int(brickHArray[i][j-1] - brickHArray[i][j])) < 8 && i < 10 && j < 10 && i > 0 && j > 0){
                piece?.position.z -= 7
                print(Float(brickHArray[i+1][j] - brickHArray[i][j]))
                let temp = (Float(brickHArray[i][j-1] - brickHArray[i][j]))
                piece?.position.y += temp
            }
            
        } else if t == "downRight" {
            let i = Int(Int((piece?.position.x)!+35)/7)
            let j = Int(Int((piece?.position.z)!+35)/7)
            print(i, j, separator:" ", terminator:"")
            print(i+1, j, separator:" ", terminator:"")
            print("down gap = ", abs(Int(brickHArray[i][j+1] - brickHArray[i][j])))
            if (abs(Int(brickHArray[i][j+1] - brickHArray[i][j])) < 8 && i < 10 && j < 10 && i > 0 && j > 0){
                piece?.position.z += 7
                let temp = (Float(brickHArray[i][j+1] - brickHArray[i][j]))
                piece?.position.y += temp
            }
            
        } else if t == "downLeft" {
            let i = Int(Int((piece?.position.x)!+35)/7)
            let j = Int(Int((piece?.position.z)!+35)/7)
            print(i, j, separator:" ", terminator:"")
            print(i+1, j, separator:" ", terminator:"")
            print("left gap = ", abs(Int(brickHArray[i-1][j] - brickHArray[i][j])))
            if (abs(Int(brickHArray[i-1][j] - brickHArray[i][j])) < 8 && i < 10 && j < 10 && i > 0 && j > 0){
                piece?.position.x -= 7
                let temp = (Float(brickHArray[i-1][j] - brickHArray[i][j]))/10
                print("temp = ", temp)
                piece?.position.y += temp
                print(piece?.position.y)
            }
        
        } else if t == "ok" {
            pieceBool = false
        }
    }
    
    func moveBrick(touch: String) {
        //check position
        if touch == "up" {
            geometryNode.position.y += 7
        } else if touch == "down" {
            print(geometryNode.boundingBox.min)
            if(geometryNode.position.y > 3.5) {
                geometryNode.position.y -= 7
            }
        } else if touch == "upRight" {
            geometryNode.position.x += 7
        } else if touch == "upLeft" {
            geometryNode.position.z -= 7
        } else if touch == "downRight" {
            geometryNode.position.z += 7
        } else if touch == "downLeft" {
            geometryNode.position.x -= 7
        } else if touch == "ok" {
            if(brickNum > 0){
                var i = Int(geometryNode.position.x)
                var j = Int(geometryNode.position.z)
                var maxHeight = 0;
                
                switch(turnState){
                case 1:
                    print("case 1:")
                    brickHArray[(i+35)/7][(j+35)/7] += Int(geometryNode.boundingBox.max.z*2)
                    break
                case 2:
                    print("case 2:")
                    for k in (0 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                        brickHArray[(i+35)/7-k][(j+35)/7] += Int(geometryNode.boundingBox.max.x*2)
                        if(brickHArray[(i+35)/7-k][(j+35)/7] > maxHeight){
                            maxHeight = brickHArray[(i+35)/7-k][(j+35)/7]
                        }
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    if((Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1 >= 1){
                        for k in (1 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                            brickHArray[(i+35)/7+k][(j+35)/7] += Int(geometryNode.boundingBox.max.x*2)
                            if(brickHArray[(i+35)/7+k][(j+35)/7] > maxHeight){
                                maxHeight = brickHArray[(i+35)/7+k][(j+35)/7]
                            }
                        }
                    }
                    
                    //syncrinize
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    for k in (0 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                        print("k = ", k)
                        print("[", (i+35)/7-k, (j+35)/7,"] = ", Int(geometryNode.boundingBox.max.x*2))
                        brickHArray[(i+35)/7-k][(j+35)/7] = maxHeight
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    if((Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1 >= 1){
                        for k in (1 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                            print("k = ", k)
                            print("[", (i+35)/7+k, (j+35)/7,"] = ", Int(geometryNode.boundingBox.max.x*2))
                            brickHArray[(i+35)/7+k][(j+35)/7] = maxHeight
                        }
                    }
                    break
                case 3:
                    print("case 3:")
                    for k in (0 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                        brickHArray[(i+35)/7][(j+35)/7-k] += Int(geometryNode.boundingBox.max.y*2)
                        if(brickHArray[(i+35)/7][(j+35)/7-k] > maxHeight){
                            maxHeight = brickHArray[(i+35)/7][(j+35)/7-k]
                        }
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    if((Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1 >= 1){
                        for k in (1 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                            brickHArray[(i+35)/7][(j+35)/7+k] += Int(geometryNode.boundingBox.max.x*2)
                            if(brickHArray[(i+35)/7][(j+35)/7+k] > maxHeight){
                                maxHeight = brickHArray[(i+35)/7][(j+35)/7+k]
                            }
                        }
                    }
                    
                    //syncrinize
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    for k in (0 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                        print("[", (i+35)/7, (j+35)/7-k,"] = ", maxHeight)
                        brickHArray[(i+35)/7][(j+35)/7-k] = maxHeight
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    if((Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1 >= 1){
                        for k in (1 ... (Int((Double(abs(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z))/7.0) + 1)/2)-1) {
                            print("[", (i+35)/7, (j+35)/7+k,"] = ", maxHeight)
                            brickHArray[(i+35)/7][(j+35)/7+k] = maxHeight
                        }
                    }
                    break
                default:
                    break
                }
                               
                var BlockLength = Double()
                if(brickNum > 1){
                    
                    print("Bug!!!")
                    // Bug: Block length = 0
                    if (indexNumberBoolL == false){
                        print("indexNumberBoolL = true!")
                        BlockLength = Double(secondBlockArray[indexNumber])
                        indexNumberBoolR = false
                    }else if(indexNumberBoolR == false){
                        print("indexNumberBoolR = true!")
                        BlockLength = Double(firstBlockArray[indexNumber])

                        indexNumberBoolL = false
                    }
                
                    
//                    if (indexNumberBoolL == true){
//                        print("indexNumberBoolL == true")
//                        let userDefaults = UserDefaults.standard
//                        block = userDefaults.integer(forKey: "firstBlock")
//                        print("block = \(block)")
//                        BlockLength = Double(block)
//                        indexNumberBoolL = false
//                    }
//                    
//                    if (indexNumberBoolR == true){
//                        print("indexNumberBoolR == true")
//                        let userDefaults = UserDefaults.standard
//                        block = userDefaults.integer(forKey: "secondBlock")
//                        print("block = \(block)")
//                        BlockLength = Double(block)
//                        indexNumberBoolR = false
//                    }
                    if(BlockLength > 0){
                        spawnShape(length: BlockLength)
                    }
                    
                }
                turnState = 3;
                print("BlockLength = ", BlockLength)
                brickNum -= 1
            }else{
                for var j in 0...9{
                    for var i in 0...9{
                        print(brickHArray[i][j], separator: ", ", terminator:"")
                    }
                    print()
                }
                pieceBool = true
//                movePiece(t: touch)
            }
        } else if touch == "turn" {
            if(turnState < 3){
                turnState += 1
            }else{
                turnState = 1
            }
            print("turn = ", turnState)
            switch(turnState){
            case 1:
                geometryNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, Float(M_PI_2))
                print("turnState = ", turnState)
                break
            case 2:
                geometryNode.rotation = SCNVector4Make(0.0, 1.0, 0.0, Float(M_PI_2))
                print("turnState = ", turnState)
                break
            case 3:
                geometryNode.rotation = SCNVector4Make(0.0, 0.0, 1.0, Float(M_PI_2))
                print("turnState = ", turnState)
                break
            default:
                break
            }
            
        } else if touch == "back" {
            print("countNumber = \(countNumber)")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DiceViewController"){
                countNumber = countNumber + 1
                show(vc,sender: self)
            }
        }
        TouchState = ""
    }
    
    func viewDidAppear(){
        print(geometryNode.hitTestWithSegment(from: SCNVector3(x: geometryNode.position.x-1,y: geometryNode.position.y-1,z: 0), to: SCNVector3(x: geometryNode.position.x+2,y: geometryNode.position.y+2,z: 0), options: [:]).count)
        
    }

}


