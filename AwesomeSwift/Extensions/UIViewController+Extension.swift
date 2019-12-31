//
//  UIViewController+Extension.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 03/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func showAlert(with message:String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.show(alert, sender: nil)
    }
}
