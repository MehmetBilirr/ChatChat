//
//  ConversationsTableViewCell.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 23.11.2022.
//

import UIKit

class ConversationsTableViewCell: UITableViewCell {

  
    private let userImageView = UIImageView()
    private let nameLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stylee()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func stylee(){
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 25
        userImageView.layer.masksToBounds = true
        userImageView.image = UIImage(named: "UserImage")
        userImageView.image = UIImage(named: "person")
        
        nameLbl.configureStyle(size: 16, weight: .regular, color: .black)
        nameLbl.text = "Mehmet Bilir"
        

    }
    
    private func layout(){
        
        contentView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        
        contentView.addSubview(nameLbl)
        
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(20)
           
        }
        
    }
    
    func configure(user:User) {
        nameLbl.text = ("\(user.firstName) \(user.lastName)")

        userImageView.sd_setImage(with: URL(string: user.imageUrl ?? ""))
    }

}

