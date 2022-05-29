//
//  FollowersViewController.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 05/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    var userDetailsModel:UserInfoModel?
    let cellReuseIdentifier = "userDetailCell"
    @IBOutlet weak var userDetailTableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var userInfoArray = [UserInfoModel]()
    var userFollowersDataArray = [UserInfoModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDetailTableView.tableFooterView = UIView()
        activityView.startAnimating()
        getUserFollowersList()
        overrideUserInterfaceStyle = .light
    }

    func getUserFollowersList() {
        UserApiManager.getUserFollowersList(searchString: self.userDetailsModel!.loginName, completionHandler: {userFollowersModel, error in
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            
            guard error == nil else {
                UIViewController.showAlert(with: error!.localizedDescription)
                return
            }
            
            if let userFollowersData = userFollowersModel {
                self.userFollowersDataArray = userFollowersData
            }
            
            if self.userFollowersDataArray.count > 0 {
                self.userDetailTableView.reloadData()
            }
            
        })
    }
}

extension FollowersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userFollowersDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserListTableViewCell
        cell.accessoryType = .none
        cell.nameLabel.text = self.userFollowersDataArray[indexPath.row].loginName
        
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
}
