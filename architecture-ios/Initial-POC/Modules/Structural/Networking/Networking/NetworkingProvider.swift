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
    
    public let publicKey: String = """
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqVqZmSucbOOH4BtbJYXe
    7Q/gTO7PfA+um8dvu8dNKKO6h5jIn1PU2ksZetKRMKBFoi8HCuARLL7BLUNpxwiR
    wcHiouSboirR1pgN8OcbHvP2hcCeePmLueahIg40lrK932M+m+f1+1G5jM8e33rJ
    oD2XGfRvdNhicnpfAOD5Q6YDZPTh7HSQ5f9i7mvoQmNJy8enR4v32ZCtZCLjuysz
    GIn+ur3xEmvUEA56XmybfMHHMOKMWDp7OlX21i9MD4NteVUfPPgUv9SUzd8wUB8N
    iWvuF9glgwYWnnLnV8ifobG5eWSdKSVc2l9jfBLII3NTNgt5SHU3fGzvf9fANxns
    HQIDAQAB
    -----END PUBLIC KEY-----
    """
    
    private var networkingDependency: NetworkingDependencyProtocol
    
    private let privateKey: String = """
    -----BEGIN RSA PRIVATE KEY-----
    MIIEogIBAAKCAQEAqVqZmSucbOOH4BtbJYXe7Q/gTO7PfA+um8dvu8dNKKO6h5jI
    n1PU2ksZetKRMKBFoi8HCuARLL7BLUNpxwiRwcHiouSboirR1pgN8OcbHvP2hcCe
    ePmLueahIg40lrK932M+m+f1+1G5jM8e33rJoD2XGfRvdNhicnpfAOD5Q6YDZPTh
    7HSQ5f9i7mvoQmNJy8enR4v32ZCtZCLjuyszGIn+ur3xEmvUEA56XmybfMHHMOKM
    WDp7OlX21i9MD4NteVUfPPgUv9SUzd8wUB8NiWvuF9glgwYWnnLnV8ifobG5eWSd
    KSVc2l9jfBLII3NTNgt5SHU3fGzvf9fANxnsHQIDAQABAoIBAG+BnuayR1GO0rUl
    bfMb3Pc739Tn3Kdz7+TUAOajyFL80uFbIKV/XgPJNOKg6EYbER5DVqC7fbN3edwi
    qfAJ3Wa1EVNtsGerR/TCs1Mt57aOrX/NnspKjMx/ZRL2RXv//nKqdtvSdCzg14o2
    Cb7dqwod43KMdiJ6Iv/7QLhkaNs3zkvYS6tE2e29WKlk6/byNJ0zAw7RsFsgK8S1
    2/CuSxhAid8BUPtmqinN7Ft8Snqe0HCgxJnSV/25rH18PY5Cx0xd8yQYxPLXkF3s
    1GxIZpkpkm3u+InUiKt2np1XP2rhqldzkVf/L5LVEvBUOOUuLa2uXuXRKgMmxJrf
    Om/O1IUCgYEA2VrGNXasGuCbzrtdem6ZyJqXiMWdVjP4eO0d6hVsMbBKtxiJfHda
    kNe5Ikt9Bmmpr7w9p4LKBi71wFdtUyJim1thl8eHzj5KzMpiPlFlDGwLk2jFfzzJ
    MQ+w3itre6VoCGYl+KIl3Upl7E7a3w9wQygquuBXT8ui1snx/KAWUL8CgYEAx3cA
    YlD8UrffDARSRdF47hDZ7ZN1bqOUi40SxUtj8Mlfc64rglXoGTVIkfBMFBxuLJE8
    //dZxZd4tqU+k1/BycZaqlMeYv82aJDwbylZCq/MmpfnSPFpj4pD5S+gquAhiEB7
    UrZxu+7YfL0z9sMt2ZBIhrW3MCTsJsLeBqiJniMCgYBuVKC2dNXqEsekSgGqa0gO
    x0JSgBVcs6bWI28C6vrvwhA7Hu5zStajHY3xdaYyQiKLfR9Cz6YjO2UtzHNHNvYc
    7Gb+t58dNwubJsR147VKd/HsUsulycJK8C8Up6+4pP7I/Kkbq5tS2DgimuiJP/n5
    bQM7tzM64yB2rS3z0YNiWwKBgCTy2lNcBSGdhefH9SWRxAD1hikII7y2+JFRNKTv
    bjfwVYosPUsLds8Um7jM9orTKWWAEfiobSy4/ld3DLxoBJHH+IuMkhhshjugfalZ
    03CzWAdbFDDi51b7mdAenniIxC1lJHMR8MeLWvbgZXvUc+3VWFn7109Hx6b2egJp
    vfRZAoGAFXHkgxxH2LJuq/hUcLKtnWMXJMRnLmjFNL1ABWhpXPnIYKTqwA2ZRNIm
    +onbWf2jbJBikAQ2+MZCL1KMSacXZpKQi/rwb9GXsWKbIxFCGaErycaOQu9E7B3q
    UpKOJWLv2VEWiwrUdETV2tKKr4JyxOZhU3UGUAQ3b41Fx6/RLDc=
    -----END RSA PRIVATE KEY-----
    """
    
    private var certificate: String?
    
    public init(networkingDependency: NetworkingDependencyProtocol) {
        self.networkingDependency = networkingDependency
    }
    
    public func getSecureHttpClient() -> HTTPClientProtocol {
        certificate = certificate == nil ? decrypt(fromBase64String: networkingDependency.getCertificate(with: publicKey), withKey: privateKey) ?? "" : certificate
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
