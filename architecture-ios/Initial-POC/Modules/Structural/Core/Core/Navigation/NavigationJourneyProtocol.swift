//
//  NavigationJourneyProtocol.swift
//  Core
//
//  Created by ACT on 30/11/21.
//

import Foundation
import UIKit
import AnalyticsInterfaces
import NetworkingInterfaces

public protocol NavigationJourneyProtocol{
    
    var belongingJourney: JourneyModule { get set }
    var nextJourney: NavigationJourneyProtocol? { get set }
    
    func start(_ journey: JourneyModule,subJourney: JourneyModule?,baseFlowDelegate: BaseFlowDelegate?,customAnalytics: JourneyModuleAnalyticsProtocol?,deepLink: URL?) -> UIViewController
    
    func next(nextJourney:NavigationJourneyProtocol)
}
