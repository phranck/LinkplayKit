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

public final class LinkplayDevice: Decodable, Identifiable, ObservableObject {
    @Published public var volume: Int = 0 {
        didSet {
//            api?.setVolume(of: self, to: volume)
        }
    }

    private let service: NetService?
    private var ipAddresses: [String] = []

    public var id: String?
    public var name: String
    public var ipv4Address: String?
    public var ipv6Address: String?
    public var macAddress: String?

    required public init(netService: NetService) {
        self.service     = netService
        self.id          = netService.macAddress
        self.name        = netService.name
        self.macAddress  = netService.macAddress
        self.ipAddresses = netService.ipAddresses
        self.ipv4Address = ipAddresses.indices.contains(0) ? ipAddresses[0] : nil
        self.ipv6Address = ipAddresses.indices.contains(1) ? ipAddresses[1] : nil
    }

    private enum CodingKeys: String, CodingKey {
        case service
        case id
        case name
        case macAddress
        case ipAddresses
        case ipv4Address
        case ipv6Address
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ipAddresses = try container.decode([String].self, forKey: .ipAddresses)
        ipv4Address = try container.decode(String.self, forKey: .ipv4Address)
        ipv6Address = try container.decode(String.self, forKey: .ipv6Address)
        macAddress = try container.decode(String.self, forKey: .macAddress)

        let serviceData = try container.decode(Data.self, forKey: .service)
        let unarchivedService = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(serviceData) as? NetService
        service = unarchivedService
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

// MARK: - Encodable

extension LinkplayDevice: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(macAddress, forKey: .macAddress)
        try container.encode(ipAddresses, forKey: .ipAddresses)
        try container.encode(ipv4Address, forKey: .ipv4Address)
        try container.encode(ipv6Address, forKey: .ipv6Address)

        if let service = service {
            try container.encode(NSKeyedArchiver.archivedData(withRootObject: service, requiringSecureCoding: false), forKey: .service)
        }
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
