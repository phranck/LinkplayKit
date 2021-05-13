//
//  LinkPlayDevice.swift
//  LinkPlay
//
//  Created by Frank Gregor on 16.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation

public class LinkPlayDevice: Identifiable, ObservableObject {
    private let service: NetService
    public let id: String?
    
    init(netService: NetService) {
        self.service = netService
        self.id = netService.macAddress
    }
    
    public var name: String {
        service.name
    }
    
    public var ipv4Address: String? {
        return ipAddresses.indices.contains(0) ? ipAddresses[0] : nil
    }
    
    public var ipv6Address: String? {
        return ipAddresses.indices.contains(1) ? ipAddresses[1] : nil
    }
    
    public var ipAddresses: [String] {
        service.ipAddresses
    }
    
    public var macAddress: String? {
        service.macAddress
    }
    
}

// MARK: - Equatable

extension LinkPlayDevice: Equatable {
    public static func == (lhs: LinkPlayDevice, rhs: LinkPlayDevice) -> Bool {
        if let lmac = lhs.macAddress, let rmac = rhs.macAddress {
            return lmac == rmac
        }
        return false
    }
}

extension LinkPlayDevice: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(macAddress)
    }
}

// MARK: - Debugging

extension LinkPlayDevice {
    public var debugDescription: String {
        var desc: String = ""

        desc.append("\(name)")
        if let id = id {
            desc.append(", ID: \(id)")
        }
        if let ipv4Address = ipv4Address {
            desc.append(", IPv4: \(ipv4Address)")
        }
        if let ipv6Address = ipv6Address {
            desc.append(", IPv6: \(ipv6Address)")
        }
        
        if let macAddress = macAddress {
            desc.append(", MAC: \(macAddress)")
        }

        return desc
    }
}
