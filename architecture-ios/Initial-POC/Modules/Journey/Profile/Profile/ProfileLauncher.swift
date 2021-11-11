//
//  ProfileLauncher.swift
//  Profile
//
//  Created by Nykolas Mayko Maia Barbosa on 09/11/21.
//

import UIKit
import Core
import NetworkingInterfaces

public class ProfileLauncher {
    static public func start(baseFlowDelegate: BaseFlowDelegate?, baseFlowDataSource: BaseFlowDataSource?, httpClient: HTTPClient) -> UIViewController {
        let businessModel = ProfileBusinessModel(repository: ProfileAPI(httpClient: httpClient), analytics: "")
        let factory = ProfileViewControllerFactory(businessModel: businessModel, analytics: businessModel)
        let mainFlow = ProfileFlow(factory: factory)
        mainFlow.baseFlowDelegate = baseFlowDelegate
        mainFlow.baseFlowDataSource = baseFlowDataSource
        factory.flow = mainFlow
        
        return mainFlow.start(useCase: businessModel, analytics: businessModel)
    }
}

