//
//  KeyChainManager.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import LocalAuthentication
import Security

enum KeyChainManager {
    @discardableResult
    static func save(_ key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    @discardableResult
    static func delete(_ key: String) -> OSStatus  {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key ] as [String : Any]

        return SecItemDelete(query as CFDictionary)
    }

    static func load(_ key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
}

extension KeyChainManager {
    static func setAccessToken(_ accessToken: String?) {
        if let accessToken = accessToken {
            let accessTokenData = accessToken.data(using: String.Encoding.utf8)!
            KeyChainManager.save("eLibrary.accessToken", data: accessTokenData)
        } else {
            KeyChainManager.delete("eLibrary.accessToken")
        }
    }
    static func getAccessToken() -> String? {
        if let accessTokenData = KeyChainManager.load("eLibrary.accessToken") {
            return String(data: accessTokenData, encoding: String.Encoding.utf8)
        }
        return nil
    }
    static func setRefreshToken(_ refreshToken: String?) {
        if let refreshToken = refreshToken {
            let refreshTokenData = refreshToken.data(using: String.Encoding.utf8)!
            KeyChainManager.save("eLibrary.refreshToken", data: refreshTokenData)
        } else {
            KeyChainManager.delete("eLibrary.refreshToken")
        }
    }
    static func getRefreshToken() -> String? {
        if let refreshTokenData = KeyChainManager.load("eLibrary.refreshToken") {
            return String(data: refreshTokenData, encoding: String.Encoding.utf8)
        }
        return nil
    }
}
