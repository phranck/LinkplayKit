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

public class LinkplayDevice: Identifiable, ObservableObject {
    @Published public var volume: Int = 0 {
        didSet {
//            api?.setVolume(of: self, to: volume)
        }
    }

    private let service: NetService?
    private var ipAddresses: [String] = []
    private var updateTime: Timer?

    public var id: String?
    public var name: String
    public var ipv4Address: String?
    public var ipv6Address: String?
    public var macAddress: String?
    public var api: Linkplay?
    
    public init(netService: NetService, api: Linkplay) {
        self.service     = netService
        self.id          = netService.macAddress
        self.name        = netService.name
        self.macAddress  = netService.macAddress
        self.ipAddresses = netService.ipAddresses
        self.ipv4Address = ipAddresses.indices.contains(0) ? ipAddresses[0] : nil
        self.ipv6Address = ipAddresses.indices.contains(1) ? ipAddresses[1] : nil

        self.api = api

        updateTime = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updatePlayerInfo), userInfo: nil, repeats: true)
    }

    @objc private func updatePlayerInfo() {
//        if let api = self.api {
//            _ = api.playerStatus(for: self)
//        }
    }

}

// MARK: - Equatable 

extension LinkplayDevice: Equatable {
    public static func == (lhs: LinkplayDevice, rhs: LinkplayDevice) -> Bool {
        if let lmac = lhs.macAddress, let rmac = rhs.macAddress {
            return lmac == rmac
        }
        return false
    }
}

extension LinkplayDevice: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(macAddress)
    }
}

// MARK: - Debugging

extension LinkplayDevice {
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
