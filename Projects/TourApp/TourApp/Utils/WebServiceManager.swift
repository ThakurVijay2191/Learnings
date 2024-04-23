//
//  WebServiceManager.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI
import Alamofire

class WebServiceManager {
    static let TAG = String(describing: WebServiceManager.self)
    static let baseUrl: URL = .init(string: "https://dummyjson.com")!
    static let appUrl: URL = .init(string: "https://squarecorn.backendless.app/api/users")!
    
    static var headers : HTTPHeaders = [
        "Content-Type": "application/json"
        
    ]
    
    static func signup(_ email: String, password: String, completion: @escaping (String,UserModel?)->Void) {
        let url = "\(appUrl)/register"
        let params: Parameters = ["email": email, "password": password]
        CommonMethods.showLog(self.TAG, "PARAMS: \(params)")
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)

        request.response { response in
            if response.response?.statusCode == 409 {
                //user already exists
                completion("User already exists.", nil)
            }else if response.response?.statusCode == 400 {
                completion("Email is invalid.", nil)
            }else if response.response?.statusCode == 200 {
                if let data = response.data {
                    do {
                        let user = try JSONDecoder().decode(UserModel.self, from: data)
                        completion("", user)
                    }catch {
                        completion(Constants.COMMON_ERROR_MESSAGE, nil)
                    }
                }else {
                    completion(Constants.COMMON_ERROR_MESSAGE, nil)
                }
                
            }else {
                completion(Constants.COMMON_ERROR_MESSAGE, nil)
            }
        }
    }
    
    static func login(_ email: String, password: String, completion: @escaping (String,UserModel?)->Void) {
        let url = "\(appUrl)/login"
        let params: Parameters = ["login": email, "password": password]
        CommonMethods.showLog(self.TAG, "PARAMS: \(params)")
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)

        request.response { response in
            if response.response?.statusCode == 401 {
                completion("Invalid login or password", nil)
            }else if response.response?.statusCode == 200 {
                if let data = response.data {
                    do {
                        let user = try JSONDecoder().decode(UserModel.self, from: data)
                        completion("", user)
                    }catch {
                        completion(Constants.COMMON_ERROR_MESSAGE, nil)
                    }
                }else {
                    completion(Constants.COMMON_ERROR_MESSAGE, nil)
                }
                
            }else {
                completion(Constants.COMMON_ERROR_MESSAGE, nil)
            }
        }
    }
    
    static func getData(completion: @escaping (Error?,[CardDataModel])->Void) {
        let url = "\(baseUrl)/products"
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default)
        
        request.responseDecodable(of: CardDataMainModel.self) { response in
            CommonMethods.showLog(self.TAG, "RESPONSE: \(response)")
            switch response.result {
            case .success(let model):
                completion(nil, model.products ?? [])
            case .failure(let error):
                completion(error, [])
            }
            
        }
    }
}
