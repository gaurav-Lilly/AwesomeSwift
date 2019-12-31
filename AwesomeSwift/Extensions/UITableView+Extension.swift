//
//  UITableView+Extension.swift
//  AwesomeSwift
//
//  Created by GauravSharma on 18/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func showEmptyTableView() {
        let emptyImageView = UIImageView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height - 40))
        emptyImageView.image = UIImage.init(named: "empty_image")
        
        self.backgroundView = emptyImageView
        self.separatorStyle = .none
    }
    
    func removeEmptyView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
