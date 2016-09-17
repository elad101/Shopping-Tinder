//
//  RegistrationViewController.swift
//  Shopping Tinder
//
//  Created by Elad Golan on 15/09/2016.
//  Copyright © 2016 AsaEl. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,
UITextFieldDelegate{
    
    
    @IBOutlet weak var yourEmailText: UITextField!
    
    @IBOutlet weak var friendEmailText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func register(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Oops!", message:"This feature isn't available right now", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(alert, animated: true){}
    }
    
}
