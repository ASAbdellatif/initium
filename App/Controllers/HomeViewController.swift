//
//  HomeViewController.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            collectionView.collectionViewLayout = collectionViewColumnLayout
            collectionView.contentInsetAdjustmentBehavior = .always
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var collectioViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomStackViwe: UIStackView!
    @IBOutlet weak var listBarButtonItem:UIBarButtonItem!
    
    let collectionViewColumnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        heightRatio: 1.2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var organizations = [Organization]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.roundCorners(radius: 20.0, borderWidth: 2.0, borderColor: .white)
        loginButton.roundCorners(radius: 10.0)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        mainView.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        
        NetworkManager().getHomeList { (list, errorString) in
            self.spinner.stopAnimating()
            if let organizationList = list {
                self.organizations = organizationList
                self.collectionView.reloadData()
            } else if let errorMessage = errorString {
                print("Error: -- \(errorMessage)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Service.shared.isUserLoggedIn() {
            bottomStackViwe.isHidden = true
        } else {
            bottomStackViwe.isHidden = false
        }
    }
    
    // MARK:- Buttons actions
    
    @IBAction func registerAction(_ sender: Any) {
    }
    
    @IBAction func loginAction(_ sender: Any) {
    }
    
    @IBAction func openSideMenu(_ sendere: Any) {
        self.drawerController?.openSide(.left)
    }
}


//MARK:- CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if organizations.count == 0 {
            return 0
        } else {
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "organizationCell", for: indexPath) as! OrganizationCollectionViewCell
        
        if indexPath.row < 3 {
            let organization = organizations[indexPath.row]
            cell.titleLabel.text = organization.nameEn
//            cell.logoImageView.kf.setImage(with: URL(string: "\(organization.logo!)"))
        } else {
            cell.titleLabel.text = "Others"
            cell.logoImageView.image = UIImage(named: "Ic_three_dots")
        }
        cell.logoContainerView.roundCorners(radius: 10.0, borderWidth: 3.0, borderColor: .gray)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectioViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        
         self.view.layoutIfNeeded()
    }
}
