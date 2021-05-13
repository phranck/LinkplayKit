//
//  LinkPlay+NetServiceBrowserDelegate.swift
//  LinkPlay
//
//  Created by Frank Gregor on 13.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation

extension LinkPlay: NetServiceBrowserDelegate {

    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        log.debug("\(service.description)")
        services.insert(service)
        service.delegate = self
        service.startMonitoring()
        service.schedule(in: .main, forMode: .common)
        service.resolve(withTimeout: 5)
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        log.debug("\(service.description)")
        services.remove(service)
    }
    
}
