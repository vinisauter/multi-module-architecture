//
//  AppNavigation+DetailFlow.swift
//  App
//
//  Created by ACT on 30/11/21.
//

import Foundation
import UIKit
import Core
import Detail

extension AppNavigation{
    
    func startDetail(from deeplink:URL? = nil,baseFlowDelegate: BaseFlowDelegate? = nil,customDetailAnalytics: JourneyModuleAnalyticsProtocol? = nil,subJourney: JourneyModule? = nil) -> UIViewController{
        
        return DetailLaucher.start(from: deeplink, baseFlowDelegate: baseFlowDelegate, httpClient: DependencyProvider.networking, analytics: DependencyProvider.analytics, customDetailAnalytics: customDetailAnalytics as? DetailAnalyticsJourneyProtocol)
    }
    
    func handleDetailFlowGo(to journey: JourneyModule,in viewController: UIViewController,with value:Any?){
        switch journey {
        case .welcome:
            push(start(.welcome,baseFlowDelegate: self,baseFlowDataSource: self),from: viewController)
            break
        default:
            break
        }
    }
    
    func handleGetDetailFlow(from journey:JourneyModule,to subJourney: JourneyModule? = nil,with baseFlowDelegate: BaseFlowDelegate,analytics: JourneyModuleAnalyticsProtocol?) -> UIViewController{
        return start(.detail,from: journey,baseFlowDelegate: baseFlowDelegate)
    }
}
