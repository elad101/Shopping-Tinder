//
//  RegistrationViewController.swift
//  Shopping Tinder
//
//  Created by Elad Golan on 15/09/2016.
//  Copyright © 2016 AsaEl. All rights reserved.
//

import UIKit
import Foundation



class RegisterViewController: UIViewController,
UITextFieldDelegate{
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var friendEmailTextField: UITextField!
    @IBOutlet weak var signupBackgroundImage: UIImageView!
    
    @IBAction func actionTriggered(_ sender: AnyObject) {
        let message = "Yours Email: "+userEmailTextField.text! +
        "\n friend's Email: "+friendEmailTextField.text!
        if (isValidEmail(testStr: userEmailTextField.text!) && isValidEmail(testStr: friendEmailTextField.text!)){
//            let alert = UIAlertController(title: "Signup", message:message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
//            self.present(alert, animated: true){}
        }
        else{
            let alert = UIAlertController(title: "Signup", message:"Email isn't valid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
            
        }
        

    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    private func textFieldDidEndEditing(_ textField1: UITextField,textField2: UITextField){
        userEmailTextField.text = textField1.text
        friendEmailTextField.text = textField2.text
    }
    
//    func md5(string: String) -> [UInt8] {
//        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
//        if let data = string.data(usingEncoding: NSUTF8StringEncoding) {
//            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
//        }
//        
//        return digest
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        friendEmailTextField.delegate = self
        

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = CGFloat(1.0)
        let border = CALayer()
        let border2 = CALayer()
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: userEmailTextField.frame.size.height - width, width:  userEmailTextField.frame.size.width, height: userEmailTextField.frame.size.height)
        
        border.borderWidth = width
        border2.borderColor = UIColor.gray.cgColor
        border2.frame = CGRect(x: 0, y: friendEmailTextField.frame.size.height - width, width:  friendEmailTextField.frame.size.width, height: friendEmailTextField.frame.size.height)
        
        border2.borderWidth = width
        userEmailTextField.layer.addSublayer(border)
        userEmailTextField.layer.masksToBounds = true
        
        friendEmailTextField.layer.addSublayer(border2)
        friendEmailTextField.layer.masksToBounds = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
