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
    
    @IBAction func actionTriggered(_ sender: AnyObject) {
        let message = "Yours Email: "+userEmailTextField.text! +
        "\n friend's Email: "+friendEmailTextField.text!
        if (isValidEmail(testStr: userEmailTextField.text!) && isValidEmail(testStr: friendEmailTextField.text!)){
            
            let alert = UIAlertController(title: "Oops!", message:message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
        else{
            let alert = UIAlertController(title: "Oops!", message:"Email isn't valid", preferredStyle: .alert)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        friendEmailTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
