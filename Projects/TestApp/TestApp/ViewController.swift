//
//  ViewController.swift
//  TestApp
//
//  Created by Nap Works on 15/04/24.
//

import UIKit
import MaccoValidator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Validator.sayHello()
        print("is Email Valid: \(Validator.isValidEmail("test@test.com"))")
        
    }


}

