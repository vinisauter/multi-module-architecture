// MARK: - Mocks generated from file: App/Handlers/HomeHandler.swift at 2022-02-08 03:29:36 +0000

//
//  HomeHandler.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import Cuckoo
@testable import App

import Core
import Home
import UIKit


 class MockHomeHandler: HomeHandler, Cuckoo.ClassMock {
    
     typealias MocksType = HomeHandler
    
     typealias Stubbing = __StubbingProxy_HomeHandler
     typealias Verification = __VerificationProxy_HomeHandler

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: HomeHandler?

     func enableDefaultImplementation(_ stub: HomeHandler) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        
    return cuckoo_manager.call("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController",
            parameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            escapingParameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            superclassCall:
                
                super.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value)
                ,
            defaultCall: __defaultImplStub!.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value))
        
    }
    
    
    
     override func canStart() -> Bool {
        
    return cuckoo_manager.call("canStart() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.canStart()
                ,
            defaultCall: __defaultImplStub!.canStart())
        
    }
    
    
    
     override func getName() -> String {
        
    return cuckoo_manager.call("getName() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getName()
                ,
            defaultCall: __defaultImplStub!.getName())
        
    }
    
    
    
     override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)  {
        
    return cuckoo_manager.call("handleGo(to: Journey, in: UIViewController, with: Any?)",
            parameters: (journey, viewController, value),
            escapingParameters: (journey, viewController, value),
            superclassCall:
                
                super.handleGo(to: journey, in: viewController, with: value)
                ,
            defaultCall: __defaultImplStub!.handleGo(to: journey, in: viewController, with: value))
        
    }
    
    
    
     override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        
    return cuckoo_manager.call("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController",
            parameters: (journey, subJourney, baseFlowDelegate, analytics),
            escapingParameters: (journey, subJourney, baseFlowDelegate, analytics),
            superclassCall:
                
                super.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics)
                ,
            defaultCall: __defaultImplStub!.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics))
        
    }
    

	 struct __StubbingProxy_HomeHandler: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.ClassStubFunction<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeHandler.self, method: "start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	    func canStart() -> Cuckoo.ClassStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeHandler.self, method: "canStart() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getName() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeHandler.self, method: "getName() -> String", parameterMatchers: matchers))
	    }
	    
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.ClassStubNoReturnFunction<(Journey, UIViewController, Any?)> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeHandler.self, method: "handleGo(to: Journey, in: UIViewController, with: Any?)", parameterMatchers: matchers))
	    }
	    
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.ClassStubFunction<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHomeHandler.self, method: "handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HomeHandler: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.__DoNotUse<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return cuckoo_manager.verify("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canStart() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("canStart() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getName() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getName() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.__DoNotUse<(Journey, UIViewController, Any?), Void> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return cuckoo_manager.verify("handleGo(to: Journey, in: UIViewController, with: Any?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.__DoNotUse<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return cuckoo_manager.verify("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HomeHandlerStub: HomeHandler {
    

    

    
     override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
     override func canStart() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func getName() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
}


// MARK: - Mocks generated from file: App/Handlers/LoginHandler.swift at 2022-02-08 03:29:36 +0000

//
//  LoginHandler.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 11/11/21.
//

import Cuckoo
@testable import App

import Core
import Login
import UIKit


 class MockLoginHandler: LoginHandler, Cuckoo.ClassMock {
    
     typealias MocksType = LoginHandler
    
     typealias Stubbing = __StubbingProxy_LoginHandler
     typealias Verification = __VerificationProxy_LoginHandler

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LoginHandler?

     func enableDefaultImplementation(_ stub: LoginHandler) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        
    return cuckoo_manager.call("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController",
            parameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            escapingParameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            superclassCall:
                
                super.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value)
                ,
            defaultCall: __defaultImplStub!.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value))
        
    }
    
    
    
     override func canStart() -> Bool {
        
    return cuckoo_manager.call("canStart() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.canStart()
                ,
            defaultCall: __defaultImplStub!.canStart())
        
    }
    
    
    
     override func getName() -> String {
        
    return cuckoo_manager.call("getName() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getName()
                ,
            defaultCall: __defaultImplStub!.getName())
        
    }
    
    
    
     override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)  {
        
    return cuckoo_manager.call("handleGo(to: Journey, in: UIViewController, with: Any?)",
            parameters: (journey, viewController, value),
            escapingParameters: (journey, viewController, value),
            superclassCall:
                
                super.handleGo(to: journey, in: viewController, with: value)
                ,
            defaultCall: __defaultImplStub!.handleGo(to: journey, in: viewController, with: value))
        
    }
    
    
    
     override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        
    return cuckoo_manager.call("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController",
            parameters: (journey, subJourney, baseFlowDelegate, analytics),
            escapingParameters: (journey, subJourney, baseFlowDelegate, analytics),
            superclassCall:
                
                super.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics)
                ,
            defaultCall: __defaultImplStub!.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics))
        
    }
    

	 struct __StubbingProxy_LoginHandler: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.ClassStubFunction<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginHandler.self, method: "start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	    func canStart() -> Cuckoo.ClassStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginHandler.self, method: "canStart() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getName() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginHandler.self, method: "getName() -> String", parameterMatchers: matchers))
	    }
	    
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.ClassStubNoReturnFunction<(Journey, UIViewController, Any?)> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginHandler.self, method: "handleGo(to: Journey, in: UIViewController, with: Any?)", parameterMatchers: matchers))
	    }
	    
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.ClassStubFunction<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLoginHandler.self, method: "handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LoginHandler: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.__DoNotUse<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return cuckoo_manager.verify("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canStart() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("canStart() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getName() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getName() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.__DoNotUse<(Journey, UIViewController, Any?), Void> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return cuckoo_manager.verify("handleGo(to: Journey, in: UIViewController, with: Any?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.__DoNotUse<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return cuckoo_manager.verify("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LoginHandlerStub: LoginHandler {
    

    

    
     override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
     override func canStart() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func getName() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
}


// MARK: - Mocks generated from file: App/Handlers/WelcomeHandler.swift at 2022-02-08 03:29:36 +0000

//
//  WelcomeHandler.swift
//  App
//
//  Created by ACT on 07/02/22.
//

import Cuckoo
@testable import App

import Core
import Foundation
import UIKit


public class MockWelcomeHandler: WelcomeHandler, Cuckoo.ClassMock {
    
    public typealias MocksType = WelcomeHandler
    
    public typealias Stubbing = __StubbingProxy_WelcomeHandler
    public typealias Verification = __VerificationProxy_WelcomeHandler

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: WelcomeHandler?

    public func enableDefaultImplementation(_ stub: WelcomeHandler) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        
    return cuckoo_manager.call("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController",
            parameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            escapingParameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            superclassCall:
                
                super.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value)
                ,
            defaultCall: __defaultImplStub!.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value))
        
    }
    
    
    
    public override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)  {
        
    return cuckoo_manager.call("handleGo(to: Journey, in: UIViewController, with: Any?)",
            parameters: (journey, viewController, value),
            escapingParameters: (journey, viewController, value),
            superclassCall:
                
                super.handleGo(to: journey, in: viewController, with: value)
                ,
            defaultCall: __defaultImplStub!.handleGo(to: journey, in: viewController, with: value))
        
    }
    
    
    
    public override func canStart() -> Bool {
        
    return cuckoo_manager.call("canStart() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.canStart()
                ,
            defaultCall: __defaultImplStub!.canStart())
        
    }
    
    
    
    public override func getName() -> String {
        
    return cuckoo_manager.call("getName() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getName()
                ,
            defaultCall: __defaultImplStub!.getName())
        
    }
    
    
    
    public override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        
    return cuckoo_manager.call("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController",
            parameters: (journey, subJourney, baseFlowDelegate, analytics),
            escapingParameters: (journey, subJourney, baseFlowDelegate, analytics),
            superclassCall:
                
                super.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics)
                ,
            defaultCall: __defaultImplStub!.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics))
        
    }
    

	public struct __StubbingProxy_WelcomeHandler: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.ClassStubFunction<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWelcomeHandler.self, method: "start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.ClassStubNoReturnFunction<(Journey, UIViewController, Any?)> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWelcomeHandler.self, method: "handleGo(to: Journey, in: UIViewController, with: Any?)", parameterMatchers: matchers))
	    }
	    
	    func canStart() -> Cuckoo.ClassStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWelcomeHandler.self, method: "canStart() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getName() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWelcomeHandler.self, method: "getName() -> String", parameterMatchers: matchers))
	    }
	    
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.ClassStubFunction<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWelcomeHandler.self, method: "handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_WelcomeHandler: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.__DoNotUse<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return cuckoo_manager.verify("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.__DoNotUse<(Journey, UIViewController, Any?), Void> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return cuckoo_manager.verify("handleGo(to: Journey, in: UIViewController, with: Any?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canStart() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("canStart() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getName() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getName() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.__DoNotUse<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return cuckoo_manager.verify("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class WelcomeHandlerStub: WelcomeHandler {
    

    

    
    public override func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
    public override func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func canStart() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func getName() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    public override func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
}


// MARK: - Mocks generated from file: Modules/Structural/Core/Core/Base/AppNavigation.swift at 2022-02-08 03:29:36 +0000

//
//  AppNavigation.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 30/11/21.
//

import Cuckoo
@testable import App

import UIKit


public class MockAppNavigation: AppNavigation, Cuckoo.ClassMock {
    
    public typealias MocksType = AppNavigation
    
    public typealias Stubbing = __StubbingProxy_AppNavigation
    public typealias Verification = __VerificationProxy_AppNavigation

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: AppNavigation?

    public func enableDefaultImplementation(_ stub: AppNavigation) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public override func setRootViewController(_ viewController: UIViewController, from currentViewController: UIViewController?, animated: Bool)  {
        
    return cuckoo_manager.call("setRootViewController(_: UIViewController, from: UIViewController?, animated: Bool)",
            parameters: (viewController, currentViewController, animated),
            escapingParameters: (viewController, currentViewController, animated),
            superclassCall:
                
                super.setRootViewController(viewController, from: currentViewController, animated: animated)
                ,
            defaultCall: __defaultImplStub!.setRootViewController(viewController, from: currentViewController, animated: animated))
        
    }
    
    
    
    public override func push(_ viewController: UIViewController, from currrentViewController: UIViewController?, animated: Bool)  {
        
    return cuckoo_manager.call("push(_: UIViewController, from: UIViewController?, animated: Bool)",
            parameters: (viewController, currrentViewController, animated),
            escapingParameters: (viewController, currrentViewController, animated),
            superclassCall:
                
                super.push(viewController, from: currrentViewController, animated: animated)
                ,
            defaultCall: __defaultImplStub!.push(viewController, from: currrentViewController, animated: animated))
        
    }
    
    
    
    public override func push(_ journey: Journey, from currentViewController: UIViewController?, animated: Bool)  {
        
    return cuckoo_manager.call("push(_: Journey, from: UIViewController?, animated: Bool)",
            parameters: (journey, currentViewController, animated),
            escapingParameters: (journey, currentViewController, animated),
            superclassCall:
                
                super.push(journey, from: currentViewController, animated: animated)
                ,
            defaultCall: __defaultImplStub!.push(journey, from: currentViewController, animated: animated))
        
    }
    
    
    
    public override func popViewController(animated: Bool)  {
        
    return cuckoo_manager.call("popViewController(animated: Bool)",
            parameters: (animated),
            escapingParameters: (animated),
            superclassCall:
                
                super.popViewController(animated: animated)
                ,
            defaultCall: __defaultImplStub!.popViewController(animated: animated))
        
    }
    
    
    
    public override func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>? {
        
    return cuckoo_manager.call("popToViewControllerWithType(_: T.Type) -> Array<UIViewController>?",
            parameters: (type),
            escapingParameters: (type),
            superclassCall:
                
                super.popToViewControllerWithType(type)
                ,
            defaultCall: __defaultImplStub!.popToViewControllerWithType(type))
        
    }
    
    
    
    public override func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)  {
        
    return cuckoo_manager.call("present(_: UIViewController, animated: Bool, completion: (() -> Void)?)",
            parameters: (viewController, animated, completion),
            escapingParameters: (viewController, animated, completion),
            superclassCall:
                
                super.present(viewController, animated: animated, completion: completion)
                ,
            defaultCall: __defaultImplStub!.present(viewController, animated: animated, completion: completion))
        
    }
    
    
    
    public override func resolve(_ rawDeeplink: String?) -> Bool {
        
    return cuckoo_manager.call("resolve(_: String?) -> Bool",
            parameters: (rawDeeplink),
            escapingParameters: (rawDeeplink),
            superclassCall:
                
                super.resolve(rawDeeplink)
                ,
            defaultCall: __defaultImplStub!.resolve(rawDeeplink))
        
    }
    
    
    
    public override func resolveDeeplinkIfNeeded()  {
        
    return cuckoo_manager.call("resolveDeeplinkIfNeeded()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.resolveDeeplinkIfNeeded()
                ,
            defaultCall: __defaultImplStub!.resolveDeeplinkIfNeeded())
        
    }
    
    
    
    public override func register(_ jorneys: Array<Journey>, with stater: ModuleHandler)  {
        
    return cuckoo_manager.call("register(_: Array<Journey>, with: ModuleHandler)",
            parameters: (jorneys, stater),
            escapingParameters: (jorneys, stater),
            superclassCall:
                
                super.register(jorneys, with: stater)
                ,
            defaultCall: __defaultImplStub!.register(jorneys, with: stater))
        
    }
    
    
    
    public override func getHandler(from jorney: Journey) -> ModuleHandler? {
        
    return cuckoo_manager.call("getHandler(from: Journey) -> ModuleHandler?",
            parameters: (jorney),
            escapingParameters: (jorney),
            superclassCall:
                
                super.getHandler(from: jorney)
                ,
            defaultCall: __defaultImplStub!.getHandler(from: jorney))
        
    }
    
    
    
    public override func start(_ journey: Journey, to subJourney: Journey?, from currentJourney: Journey?, with url: URL?, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any?, value: Any?) -> UIViewController {
        
    return cuckoo_manager.call("start(_: Journey, to: Journey?, from: Journey?, with: URL?, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any?, value: Any?) -> UIViewController",
            parameters: (journey, subJourney, currentJourney, url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, value),
            escapingParameters: (journey, subJourney, currentJourney, url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, value),
            superclassCall:
                
                super.start(journey, to: subJourney, from: currentJourney, with: url, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, customModuleAnalytics: customModuleAnalytics, value: value)
                ,
            defaultCall: __defaultImplStub!.start(journey, to: subJourney, from: currentJourney, with: url, baseFlowDelegate: baseFlowDelegate, baseFlowDataSource: baseFlowDataSource, customModuleAnalytics: customModuleAnalytics, value: value))
        
    }
    
    
    
    public override func show(_ journeys: Array<Journey>, from currentViewController: UIViewController?, animated: Bool)  {
        
    return cuckoo_manager.call("show(_: Array<Journey>, from: UIViewController?, animated: Bool)",
            parameters: (journeys, currentViewController, animated),
            escapingParameters: (journeys, currentViewController, animated),
            superclassCall:
                
                super.show(journeys, from: currentViewController, animated: animated)
                ,
            defaultCall: __defaultImplStub!.show(journeys, from: currentViewController, animated: animated))
        
    }
    

	public struct __StubbingProxy_AppNavigation: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setRootViewController<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ viewController: M1, from currentViewController: M2, animated: M3) -> Cuckoo.ClassStubNoReturnFunction<(UIViewController, UIViewController?, Bool)> where M1.MatchedType == UIViewController, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, UIViewController?, Bool)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "setRootViewController(_: UIViewController, from: UIViewController?, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func push<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ viewController: M1, from currrentViewController: M2, animated: M3) -> Cuckoo.ClassStubNoReturnFunction<(UIViewController, UIViewController?, Bool)> where M1.MatchedType == UIViewController, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, UIViewController?, Bool)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: currrentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "push(_: UIViewController, from: UIViewController?, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func push<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ journey: M1, from currentViewController: M2, animated: M3) -> Cuckoo.ClassStubNoReturnFunction<(Journey, UIViewController?, Bool)> where M1.MatchedType == Journey, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController?, Bool)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "push(_: Journey, from: UIViewController?, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func popViewController<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.ClassStubNoReturnFunction<(Bool)> where M1.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "popViewController(animated: Bool)", parameterMatchers: matchers))
	    }
	    
	    func popToViewControllerWithType<M1: Cuckoo.Matchable, T: UIViewController>(_ type: M1) -> Cuckoo.ClassStubFunction<(T.Type), Array<UIViewController>?> where M1.MatchedType == T.Type {
	        let matchers: [Cuckoo.ParameterMatcher<(T.Type)>] = [wrap(matchable: type) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "popToViewControllerWithType(_: T.Type) -> Array<UIViewController>?", parameterMatchers: matchers))
	    }
	    
	    func present<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ viewController: M1, animated: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(UIViewController, Bool, (() -> Void)?)> where M1.MatchedType == UIViewController, M2.MatchedType == Bool, M3.OptionalMatchedType == (() -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Bool, (() -> Void)?)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: animated) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "present(_: UIViewController, animated: Bool, completion: (() -> Void)?)", parameterMatchers: matchers))
	    }
	    
	    func resolve<M1: Cuckoo.OptionalMatchable>(_ rawDeeplink: M1) -> Cuckoo.ClassStubFunction<(String?), Bool> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: rawDeeplink) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "resolve(_: String?) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func resolveDeeplinkIfNeeded() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "resolveDeeplinkIfNeeded()", parameterMatchers: matchers))
	    }
	    
	    func register<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ jorneys: M1, with stater: M2) -> Cuckoo.ClassStubNoReturnFunction<(Array<Journey>, ModuleHandler)> where M1.MatchedType == Array<Journey>, M2.MatchedType == ModuleHandler {
	        let matchers: [Cuckoo.ParameterMatcher<(Array<Journey>, ModuleHandler)>] = [wrap(matchable: jorneys) { $0.0 }, wrap(matchable: stater) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "register(_: Array<Journey>, with: ModuleHandler)", parameterMatchers: matchers))
	    }
	    
	    func getHandler<M1: Cuckoo.Matchable>(from jorney: M1) -> Cuckoo.ClassStubFunction<(Journey), ModuleHandler?> where M1.MatchedType == Journey {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey)>] = [wrap(matchable: jorney) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "getHandler(from: Journey) -> ModuleHandler?", parameterMatchers: matchers))
	    }
	    
	    func start<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable, M6: Cuckoo.Matchable, M7: Cuckoo.OptionalMatchable, M8: Cuckoo.OptionalMatchable>(_ journey: M1, to subJourney: M2, from currentJourney: M3, with url: M4, baseFlowDelegate: M5, baseFlowDataSource: M6, customModuleAnalytics: M7, value: M8) -> Cuckoo.ClassStubFunction<(Journey, Journey?, Journey?, URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.OptionalMatchedType == Journey, M4.OptionalMatchedType == URL, M5.MatchedType == BaseFlowDelegate, M6.MatchedType == BaseFlowDataSource, M7.OptionalMatchedType == Any, M8.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, Journey?, URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: currentJourney) { $0.2 }, wrap(matchable: url) { $0.3 }, wrap(matchable: baseFlowDelegate) { $0.4 }, wrap(matchable: baseFlowDataSource) { $0.5 }, wrap(matchable: customModuleAnalytics) { $0.6 }, wrap(matchable: value) { $0.7 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "start(_: Journey, to: Journey?, from: Journey?, with: URL?, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any?, value: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	    func show<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ journeys: M1, from currentViewController: M2, animated: M3) -> Cuckoo.ClassStubNoReturnFunction<(Array<Journey>, UIViewController?, Bool)> where M1.MatchedType == Array<Journey>, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Array<Journey>, UIViewController?, Bool)>] = [wrap(matchable: journeys) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppNavigation.self, method: "show(_: Array<Journey>, from: UIViewController?, animated: Bool)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AppNavigation: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setRootViewController<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ viewController: M1, from currentViewController: M2, animated: M3) -> Cuckoo.__DoNotUse<(UIViewController, UIViewController?, Bool), Void> where M1.MatchedType == UIViewController, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, UIViewController?, Bool)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return cuckoo_manager.verify("setRootViewController(_: UIViewController, from: UIViewController?, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func push<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ viewController: M1, from currrentViewController: M2, animated: M3) -> Cuckoo.__DoNotUse<(UIViewController, UIViewController?, Bool), Void> where M1.MatchedType == UIViewController, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, UIViewController?, Bool)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: currrentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return cuckoo_manager.verify("push(_: UIViewController, from: UIViewController?, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func push<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ journey: M1, from currentViewController: M2, animated: M3) -> Cuckoo.__DoNotUse<(Journey, UIViewController?, Bool), Void> where M1.MatchedType == Journey, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController?, Bool)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return cuckoo_manager.verify("push(_: Journey, from: UIViewController?, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func popViewController<M1: Cuckoo.Matchable>(animated: M1) -> Cuckoo.__DoNotUse<(Bool), Void> where M1.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: animated) { $0 }]
	        return cuckoo_manager.verify("popViewController(animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func popToViewControllerWithType<M1: Cuckoo.Matchable, T: UIViewController>(_ type: M1) -> Cuckoo.__DoNotUse<(T.Type), Array<UIViewController>?> where M1.MatchedType == T.Type {
	        let matchers: [Cuckoo.ParameterMatcher<(T.Type)>] = [wrap(matchable: type) { $0 }]
	        return cuckoo_manager.verify("popToViewControllerWithType(_: T.Type) -> Array<UIViewController>?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func present<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ viewController: M1, animated: M2, completion: M3) -> Cuckoo.__DoNotUse<(UIViewController, Bool, (() -> Void)?), Void> where M1.MatchedType == UIViewController, M2.MatchedType == Bool, M3.OptionalMatchedType == (() -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Bool, (() -> Void)?)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: animated) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("present(_: UIViewController, animated: Bool, completion: (() -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func resolve<M1: Cuckoo.OptionalMatchable>(_ rawDeeplink: M1) -> Cuckoo.__DoNotUse<(String?), Bool> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: rawDeeplink) { $0 }]
	        return cuckoo_manager.verify("resolve(_: String?) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func resolveDeeplinkIfNeeded() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("resolveDeeplinkIfNeeded()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func register<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ jorneys: M1, with stater: M2) -> Cuckoo.__DoNotUse<(Array<Journey>, ModuleHandler), Void> where M1.MatchedType == Array<Journey>, M2.MatchedType == ModuleHandler {
	        let matchers: [Cuckoo.ParameterMatcher<(Array<Journey>, ModuleHandler)>] = [wrap(matchable: jorneys) { $0.0 }, wrap(matchable: stater) { $0.1 }]
	        return cuckoo_manager.verify("register(_: Array<Journey>, with: ModuleHandler)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getHandler<M1: Cuckoo.Matchable>(from jorney: M1) -> Cuckoo.__DoNotUse<(Journey), ModuleHandler?> where M1.MatchedType == Journey {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey)>] = [wrap(matchable: jorney) { $0 }]
	        return cuckoo_manager.verify("getHandler(from: Journey) -> ModuleHandler?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func start<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable, M6: Cuckoo.Matchable, M7: Cuckoo.OptionalMatchable, M8: Cuckoo.OptionalMatchable>(_ journey: M1, to subJourney: M2, from currentJourney: M3, with url: M4, baseFlowDelegate: M5, baseFlowDataSource: M6, customModuleAnalytics: M7, value: M8) -> Cuckoo.__DoNotUse<(Journey, Journey?, Journey?, URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.OptionalMatchedType == Journey, M4.OptionalMatchedType == URL, M5.MatchedType == BaseFlowDelegate, M6.MatchedType == BaseFlowDataSource, M7.OptionalMatchedType == Any, M8.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, Journey?, URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: currentJourney) { $0.2 }, wrap(matchable: url) { $0.3 }, wrap(matchable: baseFlowDelegate) { $0.4 }, wrap(matchable: baseFlowDataSource) { $0.5 }, wrap(matchable: customModuleAnalytics) { $0.6 }, wrap(matchable: value) { $0.7 }]
	        return cuckoo_manager.verify("start(_: Journey, to: Journey?, from: Journey?, with: URL?, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any?, value: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func show<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ journeys: M1, from currentViewController: M2, animated: M3) -> Cuckoo.__DoNotUse<(Array<Journey>, UIViewController?, Bool), Void> where M1.MatchedType == Array<Journey>, M2.OptionalMatchedType == UIViewController, M3.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Array<Journey>, UIViewController?, Bool)>] = [wrap(matchable: journeys) { $0.0 }, wrap(matchable: currentViewController) { $0.1 }, wrap(matchable: animated) { $0.2 }]
	        return cuckoo_manager.verify("show(_: Array<Journey>, from: UIViewController?, animated: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AppNavigationStub: AppNavigation {
    

    

    
    public override func setRootViewController(_ viewController: UIViewController, from currentViewController: UIViewController?, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func push(_ viewController: UIViewController, from currrentViewController: UIViewController?, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func push(_ journey: Journey, from currentViewController: UIViewController?, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func popViewController(animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func popToViewControllerWithType<T: UIViewController>(_ type: T.Type) -> Array<UIViewController>?  {
        return DefaultValueRegistry.defaultValue(for: (Array<UIViewController>?).self)
    }
    
    public override func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func resolve(_ rawDeeplink: String?) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func resolveDeeplinkIfNeeded()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func register(_ jorneys: Array<Journey>, with stater: ModuleHandler)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func getHandler(from jorney: Journey) -> ModuleHandler?  {
        return DefaultValueRegistry.defaultValue(for: (ModuleHandler?).self)
    }
    
    public override func start(_ journey: Journey, to subJourney: Journey?, from currentJourney: Journey?, with url: URL?, baseFlowDelegate: BaseFlowDelegate, baseFlowDataSource: BaseFlowDataSource, customModuleAnalytics: Any?, value: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
    public override func show(_ journeys: Array<Journey>, from currentViewController: UIViewController?, animated: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: Modules/Structural/Core/Core/Base/BaseFlow.swift at 2022-02-08 03:29:36 +0000

//
//  BaseFlow.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import Cuckoo
@testable import App

import UIKit


public class MockDeeplinkable: Deeplinkable, Cuckoo.ProtocolMock {
    
    public typealias MocksType = Deeplinkable
    
    public typealias Stubbing = __StubbingProxy_Deeplinkable
    public typealias Verification = __VerificationProxy_Deeplinkable

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Deeplinkable?

    public func enableDefaultImplementation(_ stub: Deeplinkable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func resolveDeeplinkIfNeeded(from controller: UIViewController)  {
        
    return cuckoo_manager.call("resolveDeeplinkIfNeeded(from: UIViewController)",
            parameters: (controller),
            escapingParameters: (controller),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.resolveDeeplinkIfNeeded(from: controller))
        
    }
    

	public struct __StubbingProxy_Deeplinkable: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func resolveDeeplinkIfNeeded<M1: Cuckoo.Matchable>(from controller: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(UIViewController)> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDeeplinkable.self, method: "resolveDeeplinkIfNeeded(from: UIViewController)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_Deeplinkable: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func resolveDeeplinkIfNeeded<M1: Cuckoo.Matchable>(from controller: M1) -> Cuckoo.__DoNotUse<(UIViewController), Void> where M1.MatchedType == UIViewController {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController)>] = [wrap(matchable: controller) { $0 }]
	        return cuckoo_manager.verify("resolveDeeplinkIfNeeded(from: UIViewController)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class DeeplinkableStub: Deeplinkable {
    

    

    
    public func resolveDeeplinkIfNeeded(from controller: UIViewController)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



public class MockBaseFlowDelegate: BaseFlowDelegate, Cuckoo.ProtocolMock {
    
    public typealias MocksType = BaseFlowDelegate
    
    public typealias Stubbing = __StubbingProxy_BaseFlowDelegate
    public typealias Verification = __VerificationProxy_BaseFlowDelegate

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: BaseFlowDelegate?

    public func enableDefaultImplementation(_ stub: BaseFlowDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?)  {
        
    return cuckoo_manager.call("perform(_: BaseFlowDelegateAction, in: UIViewController, with: Any?)",
            parameters: (action, viewController, value),
            escapingParameters: (action, viewController, value),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.perform(action, in: viewController, with: value))
        
    }
    

	public struct __StubbingProxy_BaseFlowDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func perform<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ action: M1, in viewController: M2, with value: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(BaseFlowDelegateAction, UIViewController, Any?)> where M1.MatchedType == BaseFlowDelegateAction, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(BaseFlowDelegateAction, UIViewController, Any?)>] = [wrap(matchable: action) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockBaseFlowDelegate.self, method: "perform(_: BaseFlowDelegateAction, in: UIViewController, with: Any?)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_BaseFlowDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func perform<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ action: M1, in viewController: M2, with value: M3) -> Cuckoo.__DoNotUse<(BaseFlowDelegateAction, UIViewController, Any?), Void> where M1.MatchedType == BaseFlowDelegateAction, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(BaseFlowDelegateAction, UIViewController, Any?)>] = [wrap(matchable: action) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return cuckoo_manager.verify("perform(_: BaseFlowDelegateAction, in: UIViewController, with: Any?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class BaseFlowDelegateStub: BaseFlowDelegate {
    

    

    
    public func perform(_ action: BaseFlowDelegateAction, in viewController: UIViewController, with value: Any?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



public class MockBaseFlowDataSource: BaseFlowDataSource, Cuckoo.ProtocolMock {
    
    public typealias MocksType = BaseFlowDataSource
    
    public typealias Stubbing = __StubbingProxy_BaseFlowDataSource
    public typealias Verification = __VerificationProxy_BaseFlowDataSource

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: BaseFlowDataSource?

    public func enableDefaultImplementation(_ stub: BaseFlowDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func get(_ journey: Journey, from currentJourney: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController {
        
    return cuckoo_manager.call("get(_: Journey, from: Journey, with: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController",
            parameters: (journey, currentJourney, baseFlowDelegate, customAnalytics),
            escapingParameters: (journey, currentJourney, baseFlowDelegate, customAnalytics),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.get(journey, from: currentJourney, with: baseFlowDelegate, customAnalytics: customAnalytics))
        
    }
    

	public struct __StubbingProxy_BaseFlowDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ journey: M1, from currentJourney: M2, with baseFlowDelegate: M3, customAnalytics: M4) -> Cuckoo.ProtocolStubFunction<(Journey, Journey, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.MatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: currentJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: customAnalytics) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockBaseFlowDataSource.self, method: "get(_: Journey, from: Journey, with: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_BaseFlowDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ journey: M1, from currentJourney: M2, with baseFlowDelegate: M3, customAnalytics: M4) -> Cuckoo.__DoNotUse<(Journey, Journey, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.MatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: currentJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: customAnalytics) { $0.3 }]
	        return cuckoo_manager.verify("get(_: Journey, from: Journey, with: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class BaseFlowDataSourceStub: BaseFlowDataSource {
    

    

    
    public func get(_ journey: Journey, from currentJourney: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
}



public class MockModuleHandler: ModuleHandler, Cuckoo.ProtocolMock {
    
    public typealias MocksType = ModuleHandler
    
    public typealias Stubbing = __StubbingProxy_ModuleHandler
    public typealias Verification = __VerificationProxy_ModuleHandler

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ModuleHandler?

    public func enableDefaultImplementation(_ stub: ModuleHandler) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        
    return cuckoo_manager.call("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController",
            parameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            escapingParameters: (url, baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start(from: url, with: baseFlowDelegate, baseFlowDataSource, customModuleAnalytics, subJourney, value))
        
    }
    
    
    
    public func canStart() -> Bool {
        
    return cuckoo_manager.call("canStart() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.canStart())
        
    }
    
    
    
    public func getName() -> String {
        
    return cuckoo_manager.call("getName() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getName())
        
    }
    
    
    
    public func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)  {
        
    return cuckoo_manager.call("handleGo(to: Journey, in: UIViewController, with: Any?)",
            parameters: (journey, viewController, value),
            escapingParameters: (journey, viewController, value),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.handleGo(to: journey, in: viewController, with: value))
        
    }
    
    
    
    public func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        
    return cuckoo_manager.call("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController",
            parameters: (journey, subJourney, baseFlowDelegate, analytics),
            escapingParameters: (journey, subJourney, baseFlowDelegate, analytics),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.handleGet(from: journey, to: subJourney, with: baseFlowDelegate, analytics: analytics))
        
    }
    

	public struct __StubbingProxy_ModuleHandler: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.ProtocolStubFunction<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockModuleHandler.self, method: "start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	    func canStart() -> Cuckoo.ProtocolStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockModuleHandler.self, method: "canStart() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getName() -> Cuckoo.ProtocolStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockModuleHandler.self, method: "getName() -> String", parameterMatchers: matchers))
	    }
	    
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Journey, UIViewController, Any?)> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockModuleHandler.self, method: "handleGo(to: Journey, in: UIViewController, with: Any?)", parameterMatchers: matchers))
	    }
	    
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.ProtocolStubFunction<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockModuleHandler.self, method: "handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_ModuleHandler: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func start<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable, M6: Cuckoo.OptionalMatchable>(from url: M1, with baseFlowDelegate: M2, _ baseFlowDataSource: M3, _ customModuleAnalytics: M4, _ subJourney: M5, _ value: M6) -> Cuckoo.__DoNotUse<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?), UIViewController> where M1.OptionalMatchedType == URL, M2.MatchedType == BaseFlowDelegate, M3.MatchedType == BaseFlowDataSource, M4.OptionalMatchedType == Any, M5.OptionalMatchedType == Journey, M6.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(URL?, BaseFlowDelegate, BaseFlowDataSource, Any?, Journey?, Any?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: baseFlowDelegate) { $0.1 }, wrap(matchable: baseFlowDataSource) { $0.2 }, wrap(matchable: customModuleAnalytics) { $0.3 }, wrap(matchable: subJourney) { $0.4 }, wrap(matchable: value) { $0.5 }]
	        return cuckoo_manager.verify("start(from: URL?, with: BaseFlowDelegate, _: BaseFlowDataSource, _: Any?, _: Journey?, _: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func canStart() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("canStart() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getName() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getName() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGo<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(to journey: M1, in viewController: M2, with value: M3) -> Cuckoo.__DoNotUse<(Journey, UIViewController, Any?), Void> where M1.MatchedType == Journey, M2.MatchedType == UIViewController, M3.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, UIViewController, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: viewController) { $0.1 }, wrap(matchable: value) { $0.2 }]
	        return cuckoo_manager.verify("handleGo(to: Journey, in: UIViewController, with: Any?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func handleGet<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from journey: M1, to subJourney: M2, with baseFlowDelegate: M3, analytics: M4) -> Cuckoo.__DoNotUse<(Journey, Journey?, BaseFlowDelegate, Any?), UIViewController> where M1.MatchedType == Journey, M2.OptionalMatchedType == Journey, M3.MatchedType == BaseFlowDelegate, M4.OptionalMatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Journey, Journey?, BaseFlowDelegate, Any?)>] = [wrap(matchable: journey) { $0.0 }, wrap(matchable: subJourney) { $0.1 }, wrap(matchable: baseFlowDelegate) { $0.2 }, wrap(matchable: analytics) { $0.3 }]
	        return cuckoo_manager.verify("handleGet(from: Journey, to: Journey?, with: BaseFlowDelegate, analytics: Any?) -> UIViewController", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class ModuleHandlerStub: ModuleHandler {
    

    

    
    public func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
    public func canStart() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public func getName() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    public func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController  {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
}

