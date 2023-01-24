//
//  LoginViewController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 17.10.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textLogin: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapButtonLogin(_ sender: UIButton) {
        
        guard let login = textLogin.text,
              let password = textPassword.text,
              login == "",
              password == "" else {
            show(message: "Error password/login")
            return}
        
        performSegue(withIdentifier: "Login", sender: nil)
    }
    
}
