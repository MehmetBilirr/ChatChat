//
//  UserTableViewCell.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import UIKit
import SDWebImage
class UserTableViewCell: UITableViewCell {
    private let userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        userImageView.configureImageView()
        
        nameLbl.configureStyle(size: 16, weight: .regular, color: .black)
    
    }
    
    private func layout(){
        
        contentView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(userImageView.frame.height)
            make.width.equalTo(userImageView.frame.width)
            make.bottom.equalToSuperview().offset(-10)

        }
        
        
        contentView.addSubview(nameLbl)
        
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(25)
           
        }
        
    }
    
    func configure(user:User) {
        nameLbl.text = ("\(user.firstName) \(user.lastName)")

        userImageView.sd_setImage(with: URL(string: user.imageUrl ?? ""))
    }
    
}
