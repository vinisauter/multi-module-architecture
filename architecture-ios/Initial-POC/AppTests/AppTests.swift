import XCTest
import Nimble
@testable import Login

class LoginIndexViewModelTests: XCTestCase {

    func testLoginWhenIsPassedAValidUsernameAndPasswordShouldReturnTrue() {
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())

        var wasLoginSuccess = false

        sut.login(with: "valid_username", and: "valid_password") { isSuccess in
            wasLoginSuccess = isSuccess
        }
        expect(wasLoginSuccess).to(beTrue())
    }

    func testLoginWhenIsPassedAValidUsernameAndInvalidPasswordShouldReturnFalse() {
        let sut = makeSUT(with: FakeFailureLoginIndexBusinessModel())

        var wasLoginSuccess = true

        sut.login(with: "valid_username", and: "invalid_password") { isSuccess in
            wasLoginSuccess = isSuccess
        }
        expect(wasLoginSuccess).to(beFalse())
    }
    
    func testOnForgotPasswordClickShouldCallOnForgotPasswordClickFromAnalytics() {
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())
        sut.onForgotPasswordClick(in: LoginIndexViewController(viewModel: nil))
        expect(self.fakeLoginIndexAnalytics.isValid(methods: .onForgotPasswordClick)).to(beTrue())
    }
    
    // Teste Navigation Flow
    func testAllLoginNavigationMethodOnLoginSucess(){
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())
        sut.onLoginSuccess(in: LoginIndexViewController(viewModel: nil))
        expect(self.fakeLoginIndexFlow.isValid(methods: .onLoginSuccess)).to(beTrue())
    }
    
    func testLoginNavigationMethodOnBackClick(){
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())
        sut.onLoginSuccess(in: LoginIndexViewController(viewModel: nil))
        expect(self.fakeLoginIndexFlow.isValid(methods: .onBackClick)).to(beTrue())
    }
    
    func testLoginNavigationMethodOnForgetPassword(){
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())
        sut.onLoginSuccess(in: LoginIndexViewController(viewModel: nil))
        expect(self.fakeLoginIndexFlow.isValid(methods: .onForgetPassword)).to(beTrue())
    }
    
    func testLoginNavigationMethodOnCloseClick(){
        let sut = makeSUT(with: FakeSuccessLoginIndexBusinessModel())
        sut.onLoginSuccess(in: LoginIndexViewController(viewModel: nil))
        expect(self.fakeLoginIndexFlow.isValid(methods: .onForgetPassword)).to(beTrue())
    }

    
    
    // MARK: - Helpers
    let fakeLoginIndexAnalytics = FakeLoginIndexAnalytics()
    let fakeLoginIndexFlow = FakeLoginIndexFlow()

    func makeSUT(with businessModel: LoginIndexBusinessModelProtocol) -> LoginIndexViewModel {
        return LoginIndexViewModel(businessModel: businessModel, analytics: fakeLoginIndexAnalytics, flowDelegate: fakeLoginIndexFlow)
    }

    class FakeSuccessLoginIndexBusinessModel: LoginIndexBusinessModelProtocol {

        func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
            completion(true)
        }
    }


    class FakeFailureLoginIndexBusinessModel: LoginIndexBusinessModelProtocol {

        func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
            completion(false)
        }
    }
    
    enum AnalyticLoginCallMethod{
        case onLoginClick
        case onForgotPasswordClick
    }

    class FakeLoginIndexAnalytics: LoginIndexAnalyticsProtocol {

        var calledFunctions = [AnalyticLoginCallMethod]()

        func onLoginClick() {
            calledFunctions.append(.onLoginClick)
        }
        
        func onForgotPasswordClick() {
            calledFunctions.append(.onForgotPasswordClick)
        }
        
        
        func isValid(methods: AnalyticLoginCallMethod...) -> Bool{
            let valid = called.elementsEqual(methods)
            called = []
            return valid
        }

    }
    
    enum FlowLoginCallMethod{
        case onLoginSuccess
        case onForgetPassword
        case onClose
        case onBackClick
    }

    class FakeLoginIndexFlow: LoginIndexFlowDelegate {
        
        let called = [FlowCallMethod]()

        func onLoginSuccess(in controller: LoginIndexViewController) {
            called.append(.onLoginSuccess)
        }
        func onForgotPasswordClick(in controller: LoginIndexViewController) {
            called.append(.onForgetPassword)
        }
        func onCloseClick(in controller: LoginIndexViewController) {
            called.append(.onClose)
        }
        func onBackClick(in controller: LoginIndexViewController) {
            called.append(.onBackClick)
        }
        
        func isValid(methods: FlowCallMethod...) -> Bool{
            let valid = called.elementsEqual(methods)
            called = []
            return valid
        }

    }

}
