//
//  UserDetailsViewController.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 05/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    var userDetailsModel:UserInfoModel?
    let cellReuseIdentifier = "userDetailCell"
    
    @IBOutlet weak var userDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDetailTableView.tableFooterView = UIView()
        overrideUserInterfaceStyle = .light
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserListTableViewCell
        cell.accessoryType = .none
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = self.userDetailsModel?.loginName
        case 1:
            cell.nameLabel.text = String.init(format: "%d",self.userDetailsModel!.id)
        case 2:
            if let followersUrl = self.userDetailsModel?.followersUrl {
                cell.nameLabel.text = followersUrl
            }
        case 3:
            cell.nameLabel.text = self.userDetailsModel?.url
        case 4:
            cell.nameLabel.text = "Followers"
            cell.accessoryType = .disclosureIndicator
        default:
            cell.nameLabel.text = "Undefined"
        }        
        
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let userFollowersViewController = storyBoard.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
            userFollowersViewController.userDetailsModel = self.userDetailsModel
            self.navigationController?.pushViewController(userFollowersViewController, animated: true)
        }
    }
}
