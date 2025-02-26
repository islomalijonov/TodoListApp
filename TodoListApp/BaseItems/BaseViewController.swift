//
//  BaseViewController.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import UIKit
import JGProgressHUD
import SwiftMessages

class BaseViewController: UIViewController {
    
    var progressHUD: JGProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
    }
    
    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func routeToMainViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addKeyboardToolbar(to searchBar: UISearchBar) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeKeyboard))
        
        toolbar.items = [closeButton, flexSpace]
        searchBar.inputAccessoryView = toolbar
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func showProgressHUD() {
        progressHUD = JGProgressHUD(style: .light)
        progressHUD?.show(in: view)
    }
    
    func hideProgressHUD() {
        progressHUD?.dismiss()
    }
}
