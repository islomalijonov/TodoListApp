//
//  BaseTableViewCell.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
    }
    
    func initSubviews() {
        //fatalError("Implementation pending...")
    }
    
    func embedSubviews() {
        //fatalError("Implementation pending...")
    }
    
    func addSubviewsConstraints() {
        //fatalError("Implementation pending...")
    }
    
    func localizeText() {
        //fatalError("Implementation pending...")
    }

}
