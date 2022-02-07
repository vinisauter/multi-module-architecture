import Login
import Core
import Analytics
import AnalyticsInterfaces

class MockBunissesModel: LoginIndexBusinessModelProtocol, ForgotPasswordBusinessModelProtocol, LoginAnalyticsProtocol, LoginIndexAnalyticsProtocol{

    public var repository: LoginRepositoryProtocol?
    public var structuralAnalytics: AnalyticsProtocol?
    
    public init(repository: LoginRepositoryProtocol,structuralAnalytics: AnalyticsProtocol){
        self.repository = repository
        self.structuralAnalytics = structuralAnalytics
    }
        
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        repository?.login(with: username, and: password, completion: { result in
            completion(result)
        })
    }
        
    func changePassword(with newPassword: String, completion: @escaping (Bool) -> Void) {
        repository?.changePassword(with: newPassword, completion: { result in
            completion(result)
        })
    }
    
    func onLoginClick() {
        structuralAnalytics?.track(tag: "on Login CLick")
    }
    
    func onForgotPasswordClick() {
        structuralAnalytics?.track(tag: "on Forget Password")
    }
}
