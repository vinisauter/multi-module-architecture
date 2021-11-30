//
//  JourneyDeeplink.swift
//  App
//
//  Created by Nykolas Mayko Maia Barbosa on 29/11/21.
//

import Foundation
import Core

final class JourneyDeeplink {
    public static func from(_ raw: String?) -> Deeplink<JourneyModule> {
        guard let raw = raw, let url = URL(string: raw), let host = url.host else { return Deeplink<JourneyModule>(value: .unknown, url: nil) }

        return .init(value: JourneyModule(rawValue: host), url: url)
    }
}
