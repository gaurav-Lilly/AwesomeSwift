//
//  UserListViewController.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 03/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userListTableView: UITableView!
    let cellReuseIdentifier = "userListCell"
    var searchText:String?
    
    var userInfoArray = [UserInfoModel]()
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userListTableView.tableFooterView = UIView()
        searchBar.delegate = self
        activityView.isHidden = true
        overrideUserInterfaceStyle = .light
        self.userListTableView.isHidden = true
    }
    
    @objc func searchUser(searchbar:UISearchBar) {
        activityView.startAnimating()
        self.userListTableView.removeEmptyView()
        activityView.isHidden = false
        searchbar.resignFirstResponder()
        let searchText = searchBar.text?.replacingOccurrences(of: " ", with: "")
        UserApiManager.getSearchedUsers(searchString: searchText!, completionHandler: {usersModel, error in
            
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            
            guard error == nil else {
                UIViewController.showAlert(with: error!.localizedDescription)
                return
            }
            
            if usersModel!.items.count > 0 {
                self.userInfoArray = usersModel!.items
            } else {
                self.userInfoArray.removeAll()
                //Display searched user not found.
            }
            
            self.userListTableView.isHidden = false
            self.userListTableView.reloadData()
        })
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userInfoArray.count > 0 {
            self.userListTableView.removeEmptyView()
        } else {
            self.userListTableView.showEmptyTableView()
        }
        
        return self.userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserListTableViewCell
        cell.nameLabel.text = self.userInfoArray[indexPath.row].loginName
        cell.accessoryType =  .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let userDetailViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailViewController.userDetailsModel = self.userInfoArray[indexPath.row]
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
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

extension UserListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text != "" && searchBar.text!.count > 0) {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchUser(searchbar:)), object: searchBar)
            self.perform(#selector(searchUser(searchbar:)), with: searchBar, afterDelay: 0.5)
        }
    }
}
