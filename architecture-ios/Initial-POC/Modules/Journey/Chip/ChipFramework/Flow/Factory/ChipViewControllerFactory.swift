//
//  ChipViewControllerFactory.swift
//  ChipFramework
//
//  Created by Avanade on 23/12/21.
//

import Core

class ChipViewControllerFactory: BaseViewControllerFactory<ChipBusinessModel, ChipStructuralAnalyticsProtocol> {
        
    func makeChipViewController(flow: ChipHomeFlowProtocol?) -> ChipViewController {
        
        let analyticsCustom = defaultAnalytics as? ChipAnalyticsProtocol
        let flowDelegate = flow as? ChipFlowProtocol

        let chipVM = ChipViewModel(businessModel: businessModel,
                                           analytics: analyticsCustom,
                                           flowDelegate: flowDelegate)
        
        let chipVC = ChipViewController(viewModel: chipVM)
        
        return chipVC
    }
}
