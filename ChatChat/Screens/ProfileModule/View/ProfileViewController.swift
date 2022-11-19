//
//  ProfileViewControllerViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    var profilePresenter:ViewToPresenterProfileProtocol?
    private let profileTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileRouter.createModule(ref: self, navigationController: navigationController!)
        style()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame = view.bounds
    }

}


extension ProfileViewController {
    
    func style(){
        title = "Profile"
        
        view.backgroundColor = .systemBackground
        let logOutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logOutImage, style: .plain, target: self, action: #selector(didLogOutButton(_:)))
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        view.addSubview(profileTableView)
        
    }
    
    
    @objc func didLogOutButton(_ sender:UIBarButtonItem){
        profilePresenter?.logOut()
    }
}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }
    
    
}
