//
//  BaseView.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
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
