//
//  ChipViewModel.swift
//  ChipFramework
//
//  Created by Avanade on 22/12/21.
//

import Core

protocol ChipViewModelProtocol: ChipBusinessModelProtocol, ChipFlowProtocol {}

final class ChipViewModel: BaseViewModel<ChipBusinessModelProtocol, ChipAnalyticsProtocol, ChipFlowProtocol>, ChipViewModelProtocol {

    func openProfile(in controller: ChipViewController) {
        analytics?.onOpenProfileClick()
        flowDelegate?.openProfile(in: controller)
    }
}
