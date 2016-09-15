//
//  ViewController.swift
//  Shopping Tinder
//
//  Created by Elad Golan on 14/09/2016.
//  Copyright © 2016 AsaEl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var shoppingList = ["Apple", "Banana", "Pear"];
        print(shoppingList);
        weak var addProductBtn: UIButton!
        
        
        }

    @IBAction func addProduct(_ sender: UIButton) {
        self.present(alert, animated: true, completion: nil)
        
    }
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

