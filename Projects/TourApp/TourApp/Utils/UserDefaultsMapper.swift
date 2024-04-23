//
//  UserDefaultsMapper.swift
//  SuggestMe
//
//  Created by Nap Works on 22/11/23.
//

import Foundation

class UserDefaultsMapper {
    
    let TAG = String(describing: UserDefaultsMapper.self)
    
    enum UserDefaultKeys: String {
        
        case user


        static func getAllKeys() -> [UserDefaultKeys] {
            return [.user]
        }
    }
    
    /// Saves user object to database.
    ///
    /// - Parameter user: User object to be saved to database.
    /// - Throws: An error if any value throws an error during encoding.
    static func saveUser(_ user: UserModel) throws {
        try UserDefaultsMapper.encodeAndSaveObject(user, forKey: .user)
    }
    
    static func removeCurrentUserData() {
        removeObjects(keys: UserDefaultKeys.getAllKeys())
    }
    
    /// Get user object saved to database.
    ///
    /// - Returns: User object.
    static func getUser() -> UserModel? {
        return UserDefaultsMapper.decodeObject(forKey: .user)
    }

    static func save(_ object: Any, forKey key: UserDefaultKeys) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeObjects(keys: [UserDefaultKeys]) {
        
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    
    static func getObject(key: UserDefaultKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    private static func encodeAndSaveObject<T: Encodable>(_ object: T, forKey key: UserDefaultKeys) throws {
        let encoded = try JSONEncoder().encode(object)
        save(encoded, forKey: key)
    }
    
    private static func decodeObject<T: Decodable>(forKey key: UserDefaultKeys) -> T? {
        do {
            if let encoded = getObject(key: key) as? Data {
                let decoded = try JSONDecoder().decode(T.self, from: encoded)
                return decoded
            } else {
                return nil
            }
        } catch {
            debugPrint("FAILURE: \(error.localizedDescription)")
            return nil
        }
    }

}

//print("Else in user default mappper class")
//let uid = FirebaseAPI.default.uid
//if uid.isEmpty{
//    failure("Account information not available.")
//}else{
//    FirebaseAPI.default.getUser(uid) { userDetail, error in
//        if let error = error{
//            //                            CommonMethods.showLog(TAG, "getUser error : \(error.localizedDescription)")
//            failure(error.localizedDescription)
//        }else{
//            if let userDetail = userDetail{
//                do{
//                    try UserDefaultsMapper.saveUser(userDetail)
//                }catch{
//                    //                                   CommonMethods.showLog(TAG, "getStripeCustomerId saveUser catch : \(error.localizedDescription)")
//                }
//                if Constants.IS_PAYMENT_LIVE{
//                    id = userDetail.stripeCustomerIdLive
//                }else{
//                    id = userDetail.stripeCustomerIdDev
//                }
//                if let id = id , !id.isEmpty {
//                    success(id)
//
//                }else{
//                    if let email = UserDefaultsMapper.getUser()?.email{
//                        StripeAPI.default.createCustomer(parameters: ["email" : email]) { detail in
//                            if let stripeCustomerId = detail?.id{
//                                FirebaseAPI.default.saveCustomerID(stripeCustomerId) { error in
//                                    if let error = error {
//                                        failure(error.localizedDescription)
//                                    }else{
//                                        success(stripeCustomerId)
//                                    }
//                                }
//                            }else{
//                                failure("Unable to create payment account. Please try again later")
//                            }
//                        } failure: { error, errorString in
//                            failure(errorString ?? Constants.COMMON_ERROR_MESSAGE)
//                        }
//                    }else{
//                        CommonMethods.showLog(TAG, "email ELSE")
//                        failure("Email address not available to create customer.")
//                    }
//                }
//            }else{
//                CommonMethods.showLog(TAG, "userDetail ELSE")
//                failure("Account information not available.")
//            }
//        }
//    }
//}



