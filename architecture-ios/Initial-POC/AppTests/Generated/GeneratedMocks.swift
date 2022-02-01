// MARK: - Mocks generated from file: App/AnalyticsAdapters/LoginAnalyticsProfileAdapter.swift at 2022-02-01 14:57:00 +0000

//
//  LoginAnalyticsProfileAdapter.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 18/11/21.
//

import Cuckoo
@testable import App

import AnalyticsInterfaces
import Core
import Login
import Profile


 class MockLoginAnalyticsProfileAdapter: LoginAnalyticsProfileAdapter, Cuckoo.ClassMock {
    
     typealias MocksType = LoginAnalyticsProfileAdapter
    
     typealias Stubbing = __StubbingProxy_LoginAnalyticsProfileAdapter
     typealias Verification = __VerificationProxy_LoginAnalyticsProfileAdapter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LoginAnalyticsProfileAdapter?

     func enableDefaultImplementation(_ stub: LoginAnalyticsProfileAdapter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var structuralAnalytics: AnalyticsProtocol? {
        get {
            return cuckoo_manager.getter("structuralAnalytics",
                superclassCall:
                    
                    super.structuralAnalytics
                    ,
                defaultCall: __defaultImplStub!.structuralAnalytics)
        }
        
    }
    

    

    
    
    
     override func onLoginClick()  {
        
    return cuckoo_manager.call("onLoginClick()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.onLoginClick()
                ,
            defaultCall: __defaultImplStub!.onLoginClick())
        
    }
    
    
    
     override func onForgotPasswordClick()  {
        
    return cuckoo_manager.call("onForgotPasswordClick()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.onForgotPasswordClick()
                ,
            defaultCall: __defaultImplStub!.onForgotPasswordClick())
        
    }
    
    
    
     override func onChangePasswordClick()  {
        
    return cuckoo_manager.call("onChangePasswordClick()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.onChangePasswordClick()
                ,
            defaultCall: __defaultImplStub!.onChangePasswordClick())
        
    }
    

	 struct __StubbingProxy_LoginAnalyticsProfileAdapter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var structuralAnalytics: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockLoginAnalyticsProfileAdapter, AnalyticsProtocol?> {
	        return .init(manager: cuckoo_manager, name: "structuralAnalytics")
	    }
	    
	    
	    func onLoginClick() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginAnalyticsProfileAdapter.self, method: "onLoginClick()", parameterMatchers: matchers))
	    }
	    
	    func onForgotPasswordClick() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginAnalyticsProfileAdapter.self, method: "onForgotPasswordClick()", parameterMatchers: matchers))
	    }
	    
	    func onChangePasswordClick() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginAnalyticsProfileAdapter.self, method: "onChangePasswordClick()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LoginAnalyticsProfileAdapter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var structuralAnalytics: Cuckoo.VerifyReadOnlyProperty<AnalyticsProtocol?> {
	        return .init(manager: cuckoo_manager, name: "structuralAnalytics", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func onLoginClick() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("onLoginClick()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func onForgotPasswordClick() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("onForgotPasswordClick()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func onChangePasswordClick() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("onChangePasswordClick()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LoginAnalyticsProfileAdapterStub: LoginAnalyticsProfileAdapter {
    
    
     override var structuralAnalytics: AnalyticsProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (AnalyticsProtocol?).self)
        }
        
    }
    

    

    
     override func onLoginClick()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func onForgotPasswordClick()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func onChangePasswordClick()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

