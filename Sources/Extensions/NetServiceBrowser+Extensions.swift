//
//  NetServiceBrowser+Extensions.swift
//  LinkPlay
//
//  Created by Frank Gregor on 16.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation

extension NetServiceBrowser {
    
    public func searchForServices(ofType type: NetServiceDeviceType, inDomain domainString: String = "local.") {
        searchForServices(ofType: type.rawValue, inDomain: domainString)
    }
    
}
