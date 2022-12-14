//
//  NewConversationViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit

class NewConversationViewController: UIViewController {
    private let userTableView = UITableView()
    private let searchController = UISearchController()
    var presenter:ViewToPresenterNewConversationProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        NewConversationRouter.createModule(ref: self, navigationController: navigationController)
        presenter?.viewDidLoad()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userTableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter?.fetchAllUser()
    }
    
}



extension NewConversationViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getChatUserCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        cell.configure(user: presenter?.getChatUser(indexpath: indexPath) ?? .init(firstName: "", lastName: "", uid: "", imageUrl: "", email: "", status:.Offline))
        cell.backgroundColor = .systemGreen.lighter()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
    
    
}

extension NewConversationViewController:UISearchResultsUpdating,UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        let lowerText = text.lowercased()
        presenter?.fetchFilterUser(text: lowerText)
    }
}
extension NewConversationViewController:PresenterToViewNewConversationProtocol {
   
    
    var isActive: Bool {
        searchController.isActive
    }
    

    
    func configureTableView() {
        
        view.addSubview(userTableView)
        userTableView.backgroundColor = .systemGreen.lighter()

        searchController.searchBar.barTintColor = .systemGreen.lighter()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
        userTableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
    }
    
    func reloadData() {
        userTableView.reloadData()
        
    }
    
    
}
