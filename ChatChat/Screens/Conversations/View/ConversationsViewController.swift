//
//  ViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth


 class ConversationsViewController: UIViewController {
    private let conversationsTableView = UITableView()
    var presenter:ViewToPresenterConversationsProcotol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        conversationsTableView.frame = view.bounds
    }

     
}


extension ConversationsViewController {
    
    private func setup(){
        ConversationsRouter.createModule(ref: self, navigationController: navigationController!)
        view.backgroundColor = .systemBackground
        configureTableView()
        configureBarButton()
        title = "Chats"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: .myNotification, object: nil)
    }
    
    private func configureTableView(){
        view.addSubview(conversationsTableView)
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        conversationsTableView.register(ConversationsTableViewCell.self, forCellReuseIdentifier: ConversationsTableViewCell.identifier)
        conversationsTableView.rowHeight = 70

    }
    private func configureBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton(_:)))
        
    }
    
    @objc func didTapComposeButton(_ sender :UIBarButtonItem){
        presenter?.didTapComposeButton()
    }
    
    @objc func didGetNotification(_ notification:Notification){
        if let user = notification.userInfo?["user"] as? User {
            presenter?.didGetUser(user: user)
            }
    }
}


extension ConversationsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsTableViewCell.identifier, for: indexPath) as! ConversationsTableViewCell
        return cell
    }
    
   
    
}
