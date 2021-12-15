//
//  AppSecurityProvider.swift
//  AppSecurity
//
//  Created by Nykolas Mayko Maia Barbosa on 14/12/21.
//

import Foundation
import AppSecurityInterfaces

public class AppSecurityProvider: AppSecurityProviderProtocol {
    
    public init() {}
    
    public func getCertificate() -> String {
        return """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tincidunt turpis nec tristique congue. Aliquam rhoncus, metus id dictum aliquam, ex ante vulputate magna, sit amet mattis elit lorem eu lorem. Praesent et dolor id justo fringilla vehicula interdum ac nibh. Fusce vehicula eros non diam consequat, viverra commodo nulla facilisis. Vivamus sapien metus, finibus id eros vestibulum, auctor dignissim lectus. Ut a vehicula ligula. Aliquam non nunc at tellus tincidunt auctor ac a nunc.
        """
    }
}
