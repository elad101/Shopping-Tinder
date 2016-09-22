//
//  ViewController.swift
//  Shopping Tinder
//
//  Created by Elad Golan on 14/09/2016.
//  Copyright © 2016 AsaEl. All rights reserved.
//

import UIKit
import AWSCore
import AWSS3
import AWSCognito


class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        weak var addProductBtn: UIImageView!
        
        }
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func addProduct(_ sender: AnyObject) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            //Code for launching the camera goes here
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }

        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .default) { action -> Void in
            //Code for picking from camera roll goes here
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sendItem(_ sender: AnyObject){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Shopping Tinder", message: "Are you sure you want to send this item?", preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let sendItemAction: UIAlertAction = UIAlertAction(title: "Send Item", style: .default) { action -> Void in
            // ********** Asaf Code for sending item goes here ********** 
            // This is your object String(describing: self.imagePicked.image
            
            self.uploadToS3(image: self.imagePicked.image!)
            
            let alert = UIAlertController(title: "Shopping Tinder", message:"Item has been sent", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}

        }
        actionSheetController.addAction(sendItemAction)
        //Create and add a second option action
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicked.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func uploadToS3AndReturnTask(image : UIImage) -> AWSTask<AnyObject> {
        
        print("Uploading to S3 And returning a task")
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.usEast1,
                                                                identityPoolId:"us-east-1:3042c93b-519f-4bcf-b62d-bdf3fbbd50a2")
        
        let configuration = AWSServiceConfiguration(region:.usEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let date = NSDate()
        let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
        let imageData = UIImagePNGRepresentation(image)
        let fileUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent((hashableString as String) + ".png") as NSURL
        
        do {
            try imageData?.write(to: fileUrl as URL, options: NSData.WritingOptions.atomic)
            
        } catch {
            print("Error writing file!")
        }
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.bucket = "shoppingimages"
        uploadRequest?.key = String(hashableString) //Make this random
        uploadRequest?.body = fileUrl as URL!
        uploadRequest?.contentType = "image/png"
        
        // we will track progress through an
        // AWSNetworkingUploadProgressBlock
        uploadRequest?.uploadProgress =
            {[unowned self](bytesSent:Int64,
                totalBytesSent:Int64, totalBytesExpectedToSend:Int64) in
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    print(totalBytesSent)
                    // you can have a loading stuff in here.
                })
        }
        
        
        // now the upload request is set up we can
        // create the transfermanger,
        // the credentials are already set up in the app delegate
        let transferManager:AWSS3TransferManager =
            AWSS3TransferManager.default()
        // start the upload
        let task = transferManager.upload(uploadRequest)
        
        return task!
    }
    
    
    func uploadToS3(image : UIImage) {
        
        print("Uploading to S3")

        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.usEast1,
                                                                identityPoolId:"us-east-1:3042c93b-519f-4bcf-b62d-bdf3fbbd50a2")
        
        let configuration = AWSServiceConfiguration(region:.usEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let date = NSDate()
        let hashableString = NSString(format: "%f", date.timeIntervalSinceReferenceDate)
        let imageData = UIImagePNGRepresentation(image)
        let fileUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent((hashableString as String) + ".png") as NSURL
        
        do {
            try imageData?.write(to: fileUrl as URL, options: NSData.WritingOptions.atomic)

        } catch {
            print("Error writing file!")
        }
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.bucket = "shoppingimages"
        uploadRequest?.key = String(hashableString) //Make this random
        uploadRequest?.body = fileUrl as URL!
        uploadRequest?.contentType = "image/png"
        
        // we will track progress through an
        // AWSNetworkingUploadProgressBlock
        uploadRequest?.uploadProgress =
            {[unowned self](bytesSent:Int64,
                totalBytesSent:Int64, totalBytesExpectedToSend:Int64) in
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    print(totalBytesSent)
                    // you can have a loading stuff in here.
                })
        }
        
        
        // now the upload request is set up we can
        // create the transfermanger,
        // the credentials are already set up in the app delegate
        let transferManager:AWSS3TransferManager =
            AWSS3TransferManager.default()
        // start the upload
        let task = transferManager.upload(uploadRequest)
        task?.continue({ (task) -> Any? in
            print("uploading...")
        })
        
        print("Done with uploading to S3")
        
    }
}


