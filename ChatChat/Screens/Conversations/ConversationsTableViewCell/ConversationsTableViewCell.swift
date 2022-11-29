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
    private let messageLbl = UILabel()
    private let dateLbl = UILabel()

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
      
        nameLbl.configureStyle(size: 16, weight: .regular, color: .black)

        
        messageLbl.configureStyle(size: 15, weight: .regular, color: .gray)
      
       
        
        dateLbl.configureStyle(size: 12, weight: .regular, color: .gray)
      
        

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
            make.top.equalToSuperview().offset(5 )
           
        }
        
        contentView.addSubview(messageLbl)
        messageLbl.snp.makeConstraints { make in
            make.left.equalTo(nameLbl.snp.left)
            make.top.equalTo(nameLbl.snp.bottom).offset(2)
            make.right.equalToSuperview()
            
        }
        
        contentView.addSubview(dateLbl)
        dateLbl.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-2)
            make.top.equalToSuperview()
        }
        
    }
    
    func configure(conversation:Conversation) {
        nameLbl.text = (conversation.user_name)
        handleDate(date: conversation.latest_message.date)
        handleMessage(message: conversation.latest_message.message)
        userImageView.sd_setImage(with: URL(string: conversation.user_imageUrl))
    }
    
    private func handleMessage(message:String) {
        if message.contains("https") {
            messageLbl.text = "Media"
        }else {
            messageLbl.text = message
        }
    }

    private func handleDate(date:String){
        let stringToDate = date.convertToDate()
        dateLbl.text = stringToDate.timeIn24HourFormat()
    }
}

