//
//  TodoDetailsViewControllerUI.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov  on 26/02/25.
//  

import UIKit

fileprivate protocol TodoDetailsViewControllerInstaller: ViewInstaller {
    var containerView: UIView! { get set }
    var titleLabel: UILabel! { get set }
    var completedLabel: UILabel! { get set }
    var userInfoContainer: UIView! { get set }
    var userInfoTitleLabel: UILabel! { get set }
    var userNameLabel: UILabel! { get set }
    var userAddressLabel: UILabel! { get set }
    var userEmailLabel: UILabel! { get set }
    var userPhoneLabel: UILabel! { get set }
    var userWebsiteLabel: UILabel! { get set }
    var userCompanyLabel: UILabel! { get set }
    
}

extension TodoDetailsViewControllerInstaller{
    func initSubviews() {
        containerView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 15
            addShadow(to: view)
            return view
        }()
        
        titleLabel = {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()
        
        completedLabel = {
            let label = UILabel()
            label.textColor = .green
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()
        
        userInfoContainer = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 15
            addShadow(to: view)
            return view
        }()
        
        userInfoTitleLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            return label
        }()
        
        userNameLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        userAddressLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            return label
        }()
        
        userEmailLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        userPhoneLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        userWebsiteLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        userCompanyLabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
    }
    
    func embedSubviews() {
        mainView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(completedLabel)
        
        mainView.addSubview(userInfoContainer)
        userInfoContainer.addSubview(userInfoTitleLabel)
        userInfoContainer.addSubview(userNameLabel)
        userInfoContainer.addSubview(userAddressLabel)
        userInfoContainer.addSubview(userEmailLabel)
        userInfoContainer.addSubview(userPhoneLabel)
        userInfoContainer.addSubview(userWebsiteLabel)
        userInfoContainer.addSubview(userCompanyLabel)
    }
    
    func addSubviewsConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(10)
            make.left.equalTo(containerView).offset(16)
            make.right.equalTo(containerView).offset(-16)
        }
        
        completedLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(containerView).offset(-10)
        }
        
        userInfoContainer.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(mainView.safeAreaLayoutGuide).offset(-20)
        }
        
        userInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoContainer).offset(10)
            make.left.equalTo(userInfoContainer).offset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(userInfoTitleLabel)
            make.right.equalTo(userInfoContainer).offset(-16)
        }
        
        userAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.left.equalTo(userNameLabel)
            make.right.equalTo(userInfoContainer).offset(-16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userAddressLabel.snp.bottom).offset(5)
            make.left.equalTo(userAddressLabel)
            make.right.equalTo(userInfoContainer).offset(-16)
        }
        
        userPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel.snp.bottom).offset(5)
            make.left.equalTo(userNameLabel)
        }
        
        userWebsiteLabel.snp.makeConstraints { make in
            make.top.equalTo(userPhoneLabel.snp.bottom).offset(5)
            make.left.equalTo(userNameLabel)
        }
        
        userCompanyLabel.snp.makeConstraints { make in
            make.top.equalTo(userWebsiteLabel.snp.bottom).offset(5)
            make.left.equalTo(userNameLabel)
            make.bottom.equalTo(userInfoContainer).offset(-10)
        }
        
    }
    
    func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }
}

class TodoDetailsViewControllerUI: BaseViewController, TodoDetailsViewControllerInstaller{
    var userAddressLabel: UILabel!
    
    var titleLabel: UILabel!
    
    var completedLabel: UILabel!
    
    var userInfoContainer: UIView!
    
    var userInfoTitleLabel: UILabel!
    
    var userNameLabel: UILabel!
    
    var userEmailLabel: UILabel!
    
    var userPhoneLabel: UILabel!
    
    var userWebsiteLabel: UILabel!
    
    var userCompanyLabel: UILabel!
    
    var containerView: UIView!
    
    var parameter: Any?
    
    var mainView: UIView {
        view.backgroundColor = .systemGray6
        return view
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
}
