//
//  ChipStarter.swift
//  Chip
//
//  Created by Avanade on 22/12/21.
//

import UIKit
import Core
import ChipFramework

class ChipHandler: ModuleHandler {
    
    private weak var baseFlowDelegate: BaseFlowDelegate?
    
    init() {}
    
    func start(from url: URL?, with baseFlowDelegate: BaseFlowDelegate, _ baseFlowDataSource: BaseFlowDataSource, _ customModuleAnalytics: Any?, _ subJourney: Journey?, _ value: Any?) -> UIViewController {
        self.baseFlowDelegate = baseFlowDelegate
        
        let chipDependencies = ChipDependencies(
            deeplink: url,
            flowDelegate: self,
            structuralDependencies: StructuralDependencyProvider.shared,
            customChipAnalytics: customModuleAnalytics as? ChipStructuralAnalyticsProtocol,
            value: value)
        
        return ChipLauncher.start(with: chipDependencies)
    }
    
    func canStart() -> Bool {
        return isUserLoggedIn
    }
    
    func getName() -> String {
        Journey.chip.rawValue
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

extension StructuralDependencyProvider: ChipStructuralDependencies {}

extension ChipHandler: ChipFlowDelegate {
    func goToProfile(from flow: Flow, in controller: UIViewController, with value: Any?) {
        baseFlowDelegate?.perform(.finishCurrentAndGoTo(.profile, currentJourney: .chip), in: controller, with: value)
    }
}


extension Journey {
    static let chip: Journey = Journey(rawValue: "Chip")
    static let profile: Journey = Journey(rawValue: "profile")
}
