import Foundation
import NetworkingInterfaces
import NetworkSecurity
import CryptoKit

// MARK: Structural Dependency - Detail

class SDJNetwork{
    
    private var network: HTTPClientProtocol
    private var security: ManagerSecurityNetwork
    
    init(network: HTTPClientProtocol,security: ManagerSecurityNetwork) {
        print("Login SDJ")
        self.security = security
        self.network = network
    }
    
}
