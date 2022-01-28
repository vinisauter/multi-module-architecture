import XCTest
@testable import Login
@testable import Networking
@testable import NetworkSecurity
@testable import Analytics
@testable import AnalyticsInterfaces
@testable import Core

class LoginAnalytics: AnalyticsProtocol{
    func track(tag: String) {
        
    }
}

class TestAnalytics: LoginAnalyticsProtocol, LoginIndexAnalyticsProtocol{
    
    var structuralAnalytics: AnalyticsProtocol? {
        return self.loginAnalytics
    }
    
    private let loginAnalytics: LoginAnalytics?
    
    init(analytics:Any?){
        self.loginAnalytics = analytics as? LoginAnalytics
    }
    
    func onLoginClick() {
        print("on login click")
    }
    
    func onForgotPasswordClick() {
        print("forgot password click")
    }
    
    
}

final class LoginTests: XCTestCase {
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LoginLauncher.text, "Hello, World!")
    }
    
    func testLoginNotValueDifferent(){
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy/MM/dd"
        guard let dataLast = formatDate.date(from: "2020/05/09") else { return }
        NetworkingProvider.addProvider(name: "security", ob: NetworkSecurityProvider(typeProvider: NetworkSecurityProvider.self))
        let networkSecurity = NetworkingProvider(typeProvider: NetworkingProvider.self)
        let repositoryLogin = LoginAPI(secureHttpClient: networkSecurity.getSecureHttpClient(), insecureHttpClient: networkSecurity.getInsecureHttpClient())
        let bunissesModel = LoginBusinessModel(repository: repositoryLogin, structuralAnalytics: LoginAnalytics() )
        bunissesModel.login(with: "maicon", and: "1234", completion: { (success) in
            XCTAssertEqual(success, true)
        })
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
