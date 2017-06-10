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
    
//  SKScene Nodes
    let up = SKSpriteNode(imageNamed:"up")
    let down = SKSpriteNode(imageNamed:"down")
    let upRight = SKSpriteNode(imageNamed:"upRight")
    let upLeft = SKSpriteNode(imageNamed:"upLeft")
    let downRight = SKSpriteNode(imageNamed:"downRight")
    let downLeft = SKSpriteNode(imageNamed:"downLeft")
    let ok = SKSpriteNode(imageNamed:"ok")
//  Variables
    var TouchState = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupControlBtn()
        setupScene()
        setupSKScene()
        setupCamera()
        spawnShape()
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
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 0, y: -30, z: 0)
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
        scnView.overlaySKScene = skScene
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

    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
        cameraNode.camera?.xFov = 60
        cameraNode.camera?.yFov  = 60
        cameraNode.camera?.zFar = 1000
        cameraNode.camera?.zNear = 0.01
        cameraNode.rotation = SCNVector4(0.0, 0.0, 0.0, -Float(M_PI_4))
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        geometry = SCNBox(width: 3.0, height: 3.0, length: 3.0, chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        geometryNode.position = SCNVector3(x: 0, y: 25, z: 0)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometryNode.physicsBody?.isAffectedByGravity = false
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
    
    func moveBrick(touch: String){
        //check position
        if touch == "up" {
            geometryNode.position.y += 3
        } else if touch == "down" {
            geometryNode.position.y -= 3
        } else if touch == "upRight" {
            geometryNode.position.x += 3
            geometryNode.position.z -= 3
        } else if touch == "upLeft" {
            geometryNode.position.x -= 3
            geometryNode.position.z -= 3
        } else if touch == "downRight" {
            geometryNode.position.x += 3
            geometryNode.position.z += 3
        } else if touch == "downLeft" {
            geometryNode.position.x -= 3
            geometryNode.position.z += 3
        } else if touch == "ok" {
//            for i in scnScene.rootNode.childNodes {
            
//            }
            spawnShape()
        } else if touch == "turn" {
            
        }
//        let options = [SCNHitTestRootNodeKey: sceneView.scene!.rootNode, SCNHitTestClipToZRangeKey: 15, SCNHitTestSortResultsKey: true]
//        let hits = sceneView.hitTest(point, options: options)
//        print(hits.first?.worldCoordinates)
        print(geometryNode.hitTestWithSegment(from: SCNVector3(x: geometryNode.position.x-1.5,y: geometryNode.position.y-1.5,z: 0), to: SCNVector3(x: geometryNode.position.x+2,y: geometryNode.position.y+2,z: 0), options: [:]))
        //                    print("interset!")
        TouchState = ""
    }

}


