//
//  TodoTableViewCell.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit
import SnapKit

class TodoTableViewCell: BaseTableViewCell {
    
    var containerView: UIView!
    var userInfoLabel: UILabel!
    var todoInfoLabel: UILabel!
    
    override func initSubviews() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        containerView = {
            let view = UIView()
            view.backgroundColor = UIColor(hex: "FFFFFF")
            view.layer.cornerRadius = 15
            return view
        }()
        
        userInfoLabel = {
            let label = UILabel()
            label.textColor = UIColor.black
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()
        
        todoInfoLabel = {
            let label = UILabel()
            label.textColor = UIColor.black
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            return label
        }()
        
        addShadow(to: containerView)
    }
    
    override func embedSubviews() {
        self.addSubview(containerView)
        self.containerView.addSubview(userInfoLabel)
        self.containerView.addSubview(todoInfoLabel)
    }
    
    override func addSubviewsConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
        }
        
        todoInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(12)
            make.left.equalTo(userInfoLabel.snp.left)
            make.right.equalTo(userInfoLabel.snp.right)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
        }
    }
    
    func configure(userName: String, todoTitle: String) {
        userInfoLabel.text = "👤:  \(userName)"
        todoInfoLabel.text = "📝:  \(todoTitle)"
    }
    
    func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }
}
