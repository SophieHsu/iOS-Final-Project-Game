//
//  PhotoViewController.swift
//  iOS-Game
//
//  Created by erin on 2017/5/21.
//  Copyright © 2017年 Erin Zhang. All rights reserved.
//

import UIKit
import SceneKit

var userNameArray: Array<String> = ["player_blue","player_yellow","player_red","player_green"]
var colorArray: Array<String> = ["blue","yellow","red","green"]
var userImageArray: Array<String> = []
var userLevelArray: Array<Int> = [0,0,0,0]
var diceNumberArray: Array<Int> = [0,0,0,0]
var firstBlockArray: Array<Int> = [0,0,0,0]
var secondBlockArray: Array<Int> = [0,0,0,0]


class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StartViewController"){
            show(vc,sender: self)
        }
    }
    
    @IBAction func BlueButton(_ sender: UIButton) {        
//        let userBlueImage = UIImage(named: "player_blue")
//        let imageData = UIImageJPEGRepresentation(userBlueImage!, 100)
        
        
       
    }
    @IBAction func YellowButton(_ sender: UIButton) {
//        let userBlueImage = UIImage(named: "player_yellow")
//        let imageData = UIImageJPEGRepresentation(userBlueImage!, 100)
        
//        userNameArray.append("player_yellow")
//        userLevelArray.append(0)
//        diceNumberArray.append(0)
//        firstBlockArray.append(0)
//        secondBlockArray.append(0)
        
    }
    @IBAction func RedButton(_ sender: UIButton) {
//        let userBlueImage = UIImage(named: "player_red")
//        let imageData = UIImageJPEGRepresentation(userBlueImage!, 100)
        
//        userNameArray.append("player_red")
//        userLevelArray.append(0)
//        diceNumberArray.append(0)
//        firstBlockArray.append(0)
//        secondBlockArray.append(0)

    }
    @IBAction func GreenButton(_ sender: UIButton) {
//        let userBlueImage = UIImage(named: "player_green")
//        let imageData = UIImageJPEGRepresentation(userBlueImage!, 100)
        
//        userNameArray.append("player_green")
//        userLevelArray.append(0)
//        diceNumberArray.append(0)
//        firstBlockArray.append(0)
//        secondBlockArray.append(0)

    }
//    var imagePicker: UIImagePickerController?
    @IBAction func takeAPicture(_ sender: UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            imagePicker = UIImagePickerController()
//            imagePicker?.sourceType = .camera
//            imagePicker?.delegate = self
//            imagePicker?.showsCameraControls = false
//            let controllerHeight = UIScreen.main.bounds.size.height - UIScreen.main.bounds.width * 1.333333
//            
//            let myCameraButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width/2,y: UIScreen.main.bounds.size.height/2 ,width: 95, height: 95))
//            myCameraButton.setImage(UIImage(named:"TakePhotoButtonPressed"), for: .highlighted)
//            myCameraButton.addTarget(self, action: #selector(PhotoViewController.snap), for: .touchUpInside)
//            if imagePicker != nil{
//                present(imagePicker!, animated: true, completion: nil)
//            }
//            
//        }
        
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = self
//        imagePicker.modalPresentationStyle = .popover
//        let popover = imagePicker.popoverPresentationController
//        popover?.sourceView = view
//        popover?.sourceRect = view.bounds
//        popover?.permittedArrowDirections = .any
//        show(imagePicker,sender: view)
        
    }
//    @IBOutlet weak var myImage: UIImageView!
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        myImage.image = image
//        dismiss(animated: true, completion: nil)
//    }
    
//    func snap(){
//        imagePicker?.takePicture()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
