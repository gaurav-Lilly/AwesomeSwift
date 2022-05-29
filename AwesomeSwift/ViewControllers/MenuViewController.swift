//
//  MenuViewController.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 13/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var userDetailsModel:UserInfoModel?
    let cellReuseIdentifier = "userDetailCell"
    @IBOutlet weak var userDetailTableView: UITableView!
    var userInfoArray = [UserInfoModel]()
    var featuresList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDetailTableView.tableFooterView = UIView()
        overrideUserInterfaceStyle = .light
        featuresList = ["Github user search","Pencil Kit"]
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.featuresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserListTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.text = self.featuresList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        switch indexPath.row {
        case 0:
            let userListViewController = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
            self.navigationController?.pushViewController(userListViewController, animated: true)
        case 1:
            let signatureViewController = storyBoard.instantiateViewController(withIdentifier: "SignatureViewController") as! SignatureViewController
            self.navigationController?.pushViewController(signatureViewController, animated: true)
        default:
            return
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 44 / 2)
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.09 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
}

