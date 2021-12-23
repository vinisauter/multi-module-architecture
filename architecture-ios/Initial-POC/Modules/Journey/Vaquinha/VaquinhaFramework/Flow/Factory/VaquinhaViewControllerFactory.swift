//
//  VaquinhaViewControllerFactory.swift
//  VaquinhaFramework
//
//  Created by Avanade on 23/12/21.
//

import Core

class VaquinhaViewControllerFactory: BaseViewControllerFactory<VaquinhaBusinessModel, VaquinhaStructuralAnalyticsProtocol> {
    
    weak var flow: VaquinhaHomeFlowProtocol?
    
    func makeVaquinhaViewController() -> VaquinhaViewController {
        
        let analyticsCustom = customAnalytics as? VaquinhaAnalyticsProtocol
      //  let analyticsDefault = defaultAnalytics as? VaquinhaAnalyticsProtocol
        let flowDelegate = flow as? VaquinhaFlowProtocol

        let vaquinhaVM = VaquinhaViewModel(businessModel: businessModel,
                                           analytics: analyticsCustom,
                                           flowDelegate: flowDelegate)
        
        let vaquinhaVC = VaquinhaViewController(viewModel: vaquinhaVM)
        
        return vaquinhaVC
    }
}
