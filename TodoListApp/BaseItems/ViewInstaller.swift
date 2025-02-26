//
//  ViewInstaller.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit

protocol ViewInstaller: AnyObject {
    /// The parent (root) view of all subviews
    var mainView: UIView { get }
    
    /// Additional parameter to setup subviews
    var parameter: Any? { get set }
    
    /// Initializes, then embeds subviews. Finally, adds constraints of subviews
    func setupSubviews()
    
    /// Initializes all subview elements
    func initSubviews()
    
    /// Places each subview to its super-view
    func embedSubviews()
    
    /// Adds constraints of placed subviews
    func addSubviewsConstraints()
    
    /// Localizes all texts that should be translated into local langugage
    func localizeText()
}
extension ViewInstaller {
    
    var parameter: Any? { nil }
    
    func setupSubviews() {
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
    }
    
    func initSubviews() {
        fatalError("Implementation pending...")
    }
    
    func embedSubviews() {
        fatalError("Implementation pending...")
    }
    
    func addSubviewsConstraints() {
        fatalError("Implementation pending...")
    }
    
    func localizeText() {
        fatalError("Implementation pending...")
    }
}
