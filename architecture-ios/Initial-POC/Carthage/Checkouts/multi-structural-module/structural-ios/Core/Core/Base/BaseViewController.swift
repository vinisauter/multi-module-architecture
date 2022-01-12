//
//  BaseViewController.swift
//  Core
//
//  Created by Nykolas Mayko Maia Barbosa on 10/11/21.
//

import UIKit
import Kingfisher
import SnapKit

public protocol BaseViewControllerProtocol {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
}

open class BaseViewController<ViewModel>: UIViewController, BaseViewControllerProtocol {
    public var viewModel: ViewModel?
    
    public init(viewModel: ViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDeeplinkIfNeeded()
    }
    
    open func checkDeeplinkIfNeeded() {
        if let viewModel = viewModel as? BaseViewModelProtocol, let flowDelegate: Deeplinkable = viewModel.getFlow(), viewModel.isIndex {
            flowDelegate.resolveDeeplinkIfNeeded(from: self)
        }
    }
}

