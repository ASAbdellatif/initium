//
//  SideViewController.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var isLogeddInUser = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Header")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isLogeddInUser = Service.shared.isUserLoggedIn()
        tableView.reloadData()
        
        if isLogeddInUser {
            welcomeLabel.text = "Welcome"
            let user = Service.shared.getUser()
            nameLabel.text = "\(user.firstName) \(user.lastName)"
        } else {
            nameLabel.text = ""
            welcomeLabel.text = ""
        }
    }
}


extension SideViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Service.shared.isUserLoggedIn() {
            return 2
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideCell", for: indexPath) as! SideTableViewCell
        var image: UIImage!
        if indexPath.row == 0 {
            cell.titleLabel.text = "Main Screen"
            cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
            image = UIImage(named: "Ic_home")
        }
        
        if isLogeddInUser {
            if indexPath.row == 1 {
                cell.titleLabel.text = "Log Out"
                image = UIImage(named: "Ic_home")
            }
        } else {
            if indexPath.row == 1 {
                cell.titleLabel.text = "Login to my account"
                image = UIImage(named: "Ic_home")
            } else if indexPath.row == 2 {
                cell.titleLabel.text = "Register"
                image = UIImage(named: "Ic_home")
            }
        }
        
        cell.itemImageView.image = image.withRenderingMode(.alwaysTemplate)
        cell.itemImageView.tintColor = .white
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLogeddInUser {
            Service.shared.deleteUser()
            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                withIdentifier: "navController")
            self.drawerController?.setViewController(homeController, for: .none)
            self.drawerController?.closeSide()
        } else {
            switch indexPath.row {
            case 0:
                let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                    withIdentifier: "navController")
                self.drawerController?.setViewController(homeController, for: .none)
            case 1:
                let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                    withIdentifier: "loginViewController")
                self.drawerController?.setViewController(loginController, for: .none)
            case 2:
                let registrationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                    withIdentifier: "registrationViewController")
                self.drawerController?.setViewController(registrationController, for: .none)
                
            default: break
                
            }
            
            self.drawerController?.closeSide()
        }
        
    }
    
}
