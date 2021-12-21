//
//  Networking.swift
//  Networking
//
//  Created by Nykolas Mayko Maia Barbosa on 08/11/21.
//

import Foundation
import NetworkingInterfaces

public protocol NetworkingDependencyProtocol: AnyObject {
    func getCertificate(with publicKey: String) -> String
}

open class NetworkingProvider: NetworkingProviderProtocol {
    
    public let publicKey: String = ""
    
    private var networkingDependency: NetworkingDependencyProtocol
    
    private let privateKey: String = ""
    
    private var certificate: String?
    
    public init(networkingDependency: NetworkingDependencyProtocol) {
        self.networkingDependency = networkingDependency
    }
    
    public func getSecureHttpClient() -> HTTPClientProtocol {
//        certificate = certificate == nil ? decrypt(fromBase64String: networkingDependency.getCertificate(with: publicKey), withKey: privateKey) ?? "" : certificate
        certificate = networkingDependency.getCertificate(with: publicKey)
        return LibOneHTTPClient(certificate: certificate ?? "")
    }
    
    public func getInsecureHttpClient() -> HTTPClientProtocol {
        return LibTwoHTTPClient()
    }
    
    private func decrypt(fromBase64String base64String: String?, withKey key: String) -> String? {
        guard let base64String = base64String else { return nil }
        let encryptedData = Data(base64Encoded: base64String, options: NSData.Base64DecodingOptions())
        let stringKey = key.replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----\n", with: "").replacingOccurrences(of: "\n-----END RSA PRIVATE KEY-----", with: "").replacingOccurrences(of: "\n", with: "")
        guard let _ = encryptedData, let keyData = Data(base64Encoded: stringKey) else {
            return nil
        }
        
        var attributes: CFDictionary {
            return [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                   kSecAttrKeyClass: kSecAttrKeyClassPrivate,
              kSecAttrKeySizeInBits: 2048,
            kSecReturnPersistentRef: kCFBooleanTrue as Any] as CFDictionary
        }
        
        var error: Unmanaged<CFError>? = nil
        guard let secKey = SecKeyCreateWithData(keyData as CFData, attributes, &error) else {
            print(error.debugDescription)
            return nil
        }
        
        guard let decryptedData = vDecrypt(encryptedData!, withKey: secKey) else {
            return nil
        }
        
        return String(data: decryptedData, encoding: .utf8)
    }
    
    private func vDecrypt(_ inputData: Data, withKey key: SecKey) -> Data? {
        guard inputData.count == SecKeyGetBlockSize(key) else {
            return nil
        }
        let key_size = SecKeyGetBlockSize(key)
        var decrypt_bytes = [UInt8](repeating: 0, count: key_size)
        var output_size: Int = key_size
        if SecKeyDecrypt(key, SecPadding.PKCS1, [UInt8](inputData), inputData.count, &decrypt_bytes, &output_size) == errSecSuccess {
            return Data(bytes: [UInt8](decrypt_bytes), count: output_size)
        }
        else {
            return nil
        }
    }
}
