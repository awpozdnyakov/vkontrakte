//
//  UiViewController+extention.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 24.10.2022.
//

import UIKit

extension LoginViewController {
    
    func show(message: String){
        
        let alertVC = UIAlertController(title: "Error",
                                        message: message,
                                        preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
    
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
}



