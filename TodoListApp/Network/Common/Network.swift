//
//  Network.swift
//  TodoListApp
//
//  Created by Islomjon Alijonov on 26/02/25.
//

import Foundation
import Moya
import Alamofire
import SwiftMessages
import AudioToolbox

class Network {
    static let shared = Network()
    private var requests: [Cancellable] = []
    private var isNetworkMessageShown = false
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    let provider = MoyaProvider<MultiTarget>(plugins: [
        NetworkLoggerPlugin(verbose: true, cURL: true, output: nil, requestDataFormatter: nil, responseDataFormatter: nil),
        
    ])
    
    init() {
        startNetworkReachabilityObserver()
    }
    
    func request<T: TargetType>(target: T, success successCallback: @escaping (Data) -> Void, error errorCallback: @escaping (AppError) -> Void) -> Cancellable {
        let request = provider.request(MultiTarget(target)) { [weak self] (result) in
            guard let _ = self else { return }
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                print(response)
                if statusCode >= 200 && statusCode < 300 {
                    successCallback(response.data)
                } else {
                    do {
                        let errorResponse = try JSONDecoder().decode(AppError.self, from: response.data)
                        errorCallback(AppError(
                            message: errorResponse.message,
                            responseCode: statusCode,
                            title: errorResponse.title
                        ))
                    } catch {
                        print("Error decoding server error: \(error)")
                        errorCallback(AppError(message: "Server returned \(statusCode)", responseCode: statusCode, code: nil))
                    }
                }
            case .failure(let error):
                print(error.errorDescription ?? "")
                errorCallback(AppError(message: error.errorDescription ?? "Unknown Error", responseCode: nil, code: nil))
                self?.checkAndShowNetworkMessage()
            }
        }
        self.requests.append(request)
        return request
    }
    
    func cancelAll() {
        requests.forEach({$0.cancel()})
    }
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { [weak self] status in
            switch status {
            case .notReachable:
                DispatchQueue.main.async {
                    self?.showNetworkMessage(isConnected: false)
                }
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                DispatchQueue.main.async {
                    self?.showNetworkMessage(isConnected: true)
                }
            case .unknown:
                DispatchQueue.main.async {
                    self?.showNetworkMessage(isConnected: false)
                }
            }
        }
        reachabilityManager?.startListening()
    }
    
    private func checkAndShowNetworkMessage() {
        if reachabilityManager?.isReachable == false {
            showNetworkMessage(isConnected: false)
            isNetworkMessageShown = false
        }
    }
    
    private func showNetworkMessage(isConnected: Bool) {
        if isConnected {
            if isNetworkMessageShown {
                DispatchQueue.main.async {
                    SwiftMessages.hide()
                }
                isNetworkMessageShown = false
            }
        } else {
            if !isNetworkMessageShown {
                let message = "Check your connection"
                let status = Theme.error
                
                let view = MessageView.viewFromNib(layout: .cardView)
                view.configureTheme(status)
                view.configureDropShadow()
                view.configureContent(title: "You are not online", body: message)
                view.button?.isHidden = true
                
                DispatchQueue.main.async {
                    SwiftMessages.show(view: view)
                }
                isNetworkMessageShown = true
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
}

