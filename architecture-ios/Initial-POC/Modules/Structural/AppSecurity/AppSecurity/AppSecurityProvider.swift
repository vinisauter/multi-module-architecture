//
//  AppSecurityProvider.swift
//  AppSecurity
//
//  Created by Nykolas Mayko Maia Barbosa on 14/12/21.
//

import Foundation
import AppSecurityInterfaces

public class AppSecurityProvider: AppSecurityProviderProtocol {
    
    public init() {}
    
    public func getCertificate(with publicKey: String) -> String {
        let message = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tincidunt turpis nec tristique congue. Aliquam rhoncus, metus id dictum aliquam, ex ante vulputate magna, sit amet mattis.
        """
//        let encryptedString = encrypt(string: message, publicKey: publicKey) ?? ""
                
        return message
    }
    
    private func encrypt(string: String, publicKey: String?) -> String? {
        guard let publicKey = publicKey else {
            return nil
        }
        
        let keyString = publicKey.replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----\n", with: "").replacingOccurrences(of: "\n-----END PUBLIC KEY-----", with: "").replacingOccurrences(of: "\n", with: "")
        guard let data = Data(base64Encoded: keyString) else {
            return nil
        }
        
        var attributes: CFDictionary {
            return [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                   kSecAttrKeyClass: kSecAttrKeyClassPublic,
              kSecAttrKeySizeInBits: 2048,
            kSecReturnPersistentRef: kCFBooleanTrue as Any] as CFDictionary
        }
        
        var error: Unmanaged<CFError>? = nil
        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
            print(error.debugDescription)
            return nil
        }
        return vEncrypt(string: string, publicKey: secKey)
    }
    
    private func vEncrypt(string: String, publicKey: SecKey) -> String? {
        guard let inputData = string.data(using: .utf8), inputData.count > 0 && inputData.count < SecKeyGetBlockSize(publicKey) - 11  else {
            return nil
        }
        let key_size = SecKeyGetBlockSize(publicKey)
        var encrypt_bytes = [UInt8](repeating: 0, count: key_size)
        var output_size : Int = key_size
        if SecKeyEncrypt(publicKey, SecPadding.PKCS1,
                         [UInt8](inputData), inputData.count,
                         &encrypt_bytes, &output_size) == errSecSuccess {
            return Data(bytes: [UInt8](encrypt_bytes), count: output_size).base64EncodedString()
        }
        return nil
    }
}
