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
//  Variables
    var TouchState = ""
    var brickNum = 2
    var turnState = 1
    
//  Array for brick height
    var brickHArray = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupControlBtn()
        setupScene()
        setupSKScene()
        setupCamera()
        setupPieces()
        spawnShape(length: 1)
        print(scnView.isUserInteractionEnabled)
        print(skScene.isUserInteractionEnabled)
        let tapGesture = UITapGestureRecognizer(target: self, action:
            #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
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
        }
        moveBrick(touch: TouchState)
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
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        geometryNode = SCNNode(geometry: geometry)
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
        upRight.position = CGPoint(x: 920, y: 110)

        upLeft.size = CGSize(width: 60, height: 50)
        upLeft.position = CGPoint(x: 840, y: 110)

        downRight.size = CGSize(width: 60, height: 50)
        downRight.position = CGPoint(x: 920, y: 50)
        
        downLeft.size = CGSize(width: 60, height: 50)
        downLeft.position = CGPoint(x: 840, y: 50)

        ok.size = CGSize(width: 60, height: 50)
        ok.position = CGPoint(x: 150, y: 80)

        turn.size = CGSize(width: 60, height: 50)
        turn.position = CGPoint(x: 220, y: 80)
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
        geometryNode.position = SCNVector3(x: 3.6, y: 73.5, z: 3.6)
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
//            geometryNode.position.z -= 7
        } else if touch == "upLeft" {
//            geometryNode.position.x -= 7
            geometryNode.position.z -= 7
        } else if touch == "downRight" {
//            geometryNode.position.x += 7
            geometryNode.position.z += 7
        } else if touch == "downLeft" {
            geometryNode.position.x -= 7
//            geometryNode.position.z += 7
        } else if touch == "ok" {
            if(brickNum > 0){
                var i = Int(geometryNode.position.x)
                var j = Int(geometryNode.position.z)
                let length = Double(Int(arc4random_uniform(11) + 1))
                print(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)
                print(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z)
                if(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x) >= (geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z){
                    print(Int(Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0))
                    for k in (0 ... Int((Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0) - 1)/2) {
                        print("k = ", k)
                        print((i+35)/7-k, (j+35)/7, Int(geometryNode.boundingBox.max.y), separator:" ", terminator:"")
                        brickHArray[(i+35)/7-k][(j+35)/7] = Int(geometryNode.boundingBox.max.y)
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    print(Int(Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0))
                    for k in (0 ... Int((Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0) - 1)/2) {
                        print("k = ", k)
                        print((i+35)/7+k, (j+35)/7, Int(geometryNode.boundingBox.max.y), separator:" ", terminator:"")
                        brickHArray[(i+35)/7+k][(j+35)/7] = Int(geometryNode.boundingBox.max.y)
                    }
                }else{
                    print(Int(Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0))
                    for k in (0 ... Int((Double(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z)/7.0) - 1)/2) {
                        print("k = ", k)
                        print((i+35)/7, (j+35)/7-k, Int(geometryNode.boundingBox.max.y), separator:" ", terminator:"")
                        brickHArray[(i+35)/7][(j+35)/7-k] = Int(geometryNode.boundingBox.max.y)
                    }
                    i = Int(geometryNode.position.x)
                    j = Int(geometryNode.position.z)
                    print(Int(Double(geometryNode.boundingBox.max.x - geometryNode.boundingBox.min.x)/7.0))
                    for k in (0 ... Int((Double(geometryNode.boundingBox.max.z - geometryNode.boundingBox.min.z)/7.0) - 1)/2) {
                        print("k = ", k)
                        print((i+35)/7, (j+35)/7+k, Int(geometryNode.boundingBox.max.y), separator:" ", terminator:"")
                        brickHArray[(i+35)/7][(j+35)/7+k] = Int(geometryNode.boundingBox.max.y)
                    }
                }
                brickHArray[(i+35)/7][(j+35)/7] = Int(geometryNode.boundingBox.max.y)
                spawnShape(length: length)
                brickNum -= 1
            }else{
                for var j in 0...9{
                    for var i in 0...9{
                        print(brickHArray[i][j], terminator:"")
                    }
                    print()
                }
//                movePiece()
            }
        } else if touch == "turn" {
            if(turnState < 3){
                turnState += 1
            }else{
                turnState = 1
            }
            switch(turnState){
            case 1:
                geometryNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, Float(M_PI_2))
                break
            case 2:
                geometryNode.rotation = SCNVector4Make(0.0, 1.0, 0.0, Float(M_PI_2))
                break
            case 3:
                geometryNode.rotation = SCNVector4Make(0.0, 0.0, 1.0, Float(M_PI_2))
                break
            default:
                break
            }
            
        }
//        let options = [SCNHitTestRootNodeKey: sceneView.scene!.rootNode, SCNHitTestClipToZRangeKey: 15, SCNHitTestSortResultsKey: true]
//        let hits = sceneView.hitTest(point, options: options)
//        print(hits.first?.worldCoordinates)
//        print(geometryNode.position)
//        print(geometryNode.position.x-2)
//        print(geometryNode.position.y-2)
//        print(geometryNode.position.z-2)
//        print(geometryNode.hitTestWithSegment(from: SCNVector3(x: geometryNode.position.x-2,y: geometryNode.position.y-2,z: geometryNode.position.z-2), to: SCNVector3(x: geometryNode.position.x+2,y: geometryNode.position.y+2,z: geometryNode.position.z+2), options: [:]).count)
////        //                    print("interset!")
        TouchState = ""
    }
    
    func viewDidAppear(){
        print(geometryNode.hitTestWithSegment(from: SCNVector3(x: geometryNode.position.x-1,y: geometryNode.position.y-1,z: 0), to: SCNVector3(x: geometryNode.position.x+2,y: geometryNode.position.y+2,z: 0), options: [:]).count)
        
    }

}


