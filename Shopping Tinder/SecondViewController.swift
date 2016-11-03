//
//  ViewController.swift
//  Shopping Tinder
//
//  Created by Elad Golan on 14/09/2016.
//  Copyright © 2016 AsaEl. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        weak var addProductBtn: UIImageView!
        
        }
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func addProduct(_ sender: AnyObject) {
        //self.present(alert, animated: true, completion: nil)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicked.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


