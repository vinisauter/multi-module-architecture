//
//  MockBaseFlowDataSource.swift
//  HandlersTests
//
//  Created by Nykolas Mayko Maia Barbosa on 27/01/22.
//

import UIKit
import Core

class FakeBaseFlowDataSource: BaseFlowDataSource {
    func get(_ journey: Journey, from currentJourney: Journey, with baseFlowDelegate: BaseFlowDelegate, customAnalytics: Any?) -> UIViewController {
        return UIViewController()
    }
}
