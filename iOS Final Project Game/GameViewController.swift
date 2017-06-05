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

class GameViewController: UIViewController, SKSceneDelegate, SCNSceneRendererDelegate, SCNPhysicsContactDelegate{
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var spawnTime:TimeInterval = 0
    
//    let base = SKSpriteNode(imageNamed:"arrow")
    let up = SKSpriteNode(imageNamed:"up")
    let down = SKSpriteNode(imageNamed:"down")
    let upRight = SKSpriteNode(imageNamed:"upRight")
    let upLeft = SKSpriteNode(imageNamed:"upLeft")
    let downRight = SKSpriteNode(imageNamed:"downRight")
    let downLeft = SKSpriteNode(imageNamed:"downLeft")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupControlBtn()
        setupScene()
        setupSKScene()
        setupCamera()
        spawnShape()
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
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
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
        var geometry:SCNGeometry
        geometry = SCNBox(width: 100.0, height: 0.0, length: 100.0, chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 0, y: 25, z: 0)
        geometryNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, Float(M_PI_4))
    }
    
    func setupSKScene(){
        let skScene = SKScene(size: CGSize(width: 100, height: 100))
        skScene.backgroundColor = UIColor.green
        skScene.addChild(up)
        skScene.addChild(down)
        skScene.addChild(upRight)
        skScene.addChild(upLeft)
        skScene.addChild(downRight)
        skScene.addChild(downLeft)
        scnView.overlaySKScene = skScene
    }
    
    func setupControlBtn(){
        up.size = CGSize(width: 6, height: 5)
        up.position = CGPoint(x: 8, y: 11)
        
        down.size = CGSize(width: 6, height: 5)
        down.position = CGPoint(x: 8, y: 5)
        
        upRight.size = CGSize(width: 6, height: 5)
        upRight.position = CGPoint(x: 92, y: 11)
        
        upLeft.size = CGSize(width: 6, height: 5)
        upLeft.position = CGPoint(x: 84, y: 11)
        
        downRight.size = CGSize(width: 6, height: 5)
        downRight.position = CGPoint(x: 92, y: 5)
        
        downLeft.size = CGSize(width: 6, height: 5)
        downLeft.position = CGPoint(x: 84, y: 5)
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 50, z: 100)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        var geometry:SCNGeometry
        geometry = SCNBox(width: 3.0, height: 3.0, length: 3.0, chamferRadius: 0.0)
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 0, y: 25, z: 0)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometryNode.physicsBody?.isAffectedByGravity = false
        geometryNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, Float(M_PI_4))
//        let force = SCNVector3(x: 1, y: 1 , z: 1)
//        var position = SCNVector3(x: 1.0, y: 0.0, z: 0.0)
//        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
//        geometryNode.physicsBody?.clearAllForces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
