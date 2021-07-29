/*
 The MIT License (MIT)
 
 Copyright © 2021 Frank Gregor <phranck@woodbytes.me>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the “Software”), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
