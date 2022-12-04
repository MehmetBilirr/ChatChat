//
//  ChatStatusView.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 30.11.2022.
//

import UIKit
import SnapKit

class ChatStatusView: UIView {
    
    let nameLbl = UILabel()
    var statusLbl = UILabel()
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style(){
        
        backgroundColor = .systemGreen.lighter()
        nameLbl.configureStyle(size: 12, weight: .medium, color: .black)
        
        statusLbl.configureStyle(size: 10, weight: .regular, color: .secondaryLabel)
        
        imageView.configureImageView()
        
    }
    private func layout(){
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
            make.height.equalTo(imageView.frame.width)
            make.width.equalTo(imageView.frame.height)
        }
        
        addSubview(statusLbl)
        statusLbl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
        
        addSubview(nameLbl)
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.bottom.equalTo(statusLbl.snp.top)
        }
        
        
    }
    
    
}
