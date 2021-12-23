//
//  VaquinhaViewModel.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import Core

public protocol VaquinhaViewModelProtocol: VaquinhaBusinessModelProtocol, VaquinhaFlowProtocol {}

class VaquinhaViewModel: BaseViewModel<VaquinhaBusinessModelProtocol, VaquinhaAnalyticsProtocol, VaquinhaFlowProtocol>, VaquinhaViewModelProtocol {
   
    
    func openProfile(in controller: VaquinhaViewController) {
        analytics?.onOpenProfileClick()
        flowDelegate?.openProfile(in: controller)
    }
}
