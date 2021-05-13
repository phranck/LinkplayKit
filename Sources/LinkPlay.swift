//
//  LinkPlay.swift
//  LinkPlay
//
//  Created by Frank Gregor on 13.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

public class LinkPlay: NSObject, ObservableObject {
    
    public static let shared = LinkPlay()
    private override init() {}
    
    internal let browser = NetServiceBrowser()
    internal var services: Set<NetService> = Set()

    // MARK: - Public API

    @Published public var devices: Set<LinkPlayDevice> = []
    
    // MARK: - Device Discovery
    
    public func startBrowsing() {
        browser.delegate = self
        browser.searchForServices(ofType: .LinkPlay)
        browser.schedule(in: .main, forMode: .common)
    }
    
    public func stopBrowsing() {
        browser.stop()
        browser.remove(from: .main, forMode: .common)
    }

    // MARK: - Device Persistence Handling

    public func createOrUpdateDevice(forService service: NetService) {
        devices.update(with: LinkPlayDevice(netService: service))
    }
    
    public func device(forService service: NetService) -> LinkPlayDevice? {
        let searchDevice = LinkPlayDevice(netService: service)
        let result = devices.filter { device in
            return device == searchDevice
        }
        
        if result.isSubset(of: devices) {
            return result.first
        }
        
        return nil
    }
    
    public func removeDevice(forService service: NetService) -> LinkPlayDevice? {
        if let device = device(forService: service) {
            devices.remove(device)
            services.remove(service)
            service.stopMonitoring()
            return device
        }

        return nil
    }
    
}

public enum NetServiceDeviceType: String {
    case LinkPlay = "_linkplay._tcp."
}
