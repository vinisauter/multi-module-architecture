//
//  VaquinhaStarter.swift
//  Vaquinha
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core
import VaquinhaFramework

class VaquinhaHandler: ModuleHandler {
    
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let vaquinhaDependencies = VaquinhaDependencies(
            deeplink: url,
            flowDelegate: self,
            structuralDependencies: StructuralDependencyProvider.shared,
            customVaquinhaAnalytics: customModuleAnalytics as? VaquinhaStructuralAnalyticsProtocol,
            value: value)
        
        return VaquinhaLauncher.start(with: vaquinhaDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        Journey.vaquinha.rawValue
    }
    
    func handleGo(to journey: Journey, in viewController: UIViewController, with value: Any?) {
        switch journey {
        case .profile:
            AppNavigation.shared.show([.profile], animated: false)
            isUserLoggedIn = false
            break
        default: break
        }
    }
    
    func handleGet(from journey: Journey, to subJourney: Journey?, with baseFlowDelegate: BaseFlowDelegate, analytics: Any?) -> UIViewController {
        let startVC = start(from: nil, with: baseFlowDelegate, AppNavigation.shared, analytics, subJourney, nil)
        
        return startVC
    }
}

extension StructuralDependencyProvider: VaquinhaStructuralDependencies {}

extension VaquinhaHandler: VaquinhaFlowDelegate {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.profile, currentJourney: .vaquinha), in: controller, with: value)
    }
}


extension Journey {
    static let vaquinha: Journey = Journey(rawValue: "vaquinha")
    static let profile: Journey = Journey(rawValue: "profile")
}
