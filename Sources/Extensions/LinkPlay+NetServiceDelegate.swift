//
//  LinkPlay+NetServiceDelegate.swift
//  LinkPlay
//
//  Created by Frank Gregor on 13.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation

extension LinkPlay: NetServiceDelegate {
    
    public func netServiceWillResolve(_ service: NetService) {
        log.debug("\(service.description)")
    }

    public func netService(_ service: NetService, didUpdateTXTRecord data: Data) {
        log.debug("\(service.description)")
    }
    
    public func netServiceDidResolveAddress(_ service: NetService) {
        log.debug("\(service.description)")
        createOrUpdateDevice(forService: service)
    }
    
    public func netServiceDidStop(_ service: NetService) {
        log.debug("\(service.description)")
    }
    
}
