//
//  VaquinhaViewModel.swift
//  VaquinhaFramework
//
//  Created by Avanade on 22/12/21.
//

import Core

protocol VaquinhaViewModelProtocol: VaquinhaBusinessModelProtocol, VaquinhaFlowDelegate {}

class VaquinhaViewModel: BaseViewModel<VaquinhaBusinessModelProtocol, VaquinhaAnalyticsProtocol, VaquinhaFlowDelegate>, VaquinhaViewModelProtocol {
   
    
    func openProfile(in controller: VaquinhaViewController) {
        analytics?.onOpenProfileClick()
        flowDelegate?.openProfile(in: controller)
    }
    
}


public protocol VaquinhaFlowDelegate: AnyObject {
    func openProfile(in controller: VaquinhaViewController)
}


//AMNHA CONTINUAR NA VIEWCONTROLLER E DEPOIS FLOW 
