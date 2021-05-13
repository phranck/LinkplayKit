//
//  NetService+Extensions.swift
//  LinkPlay
//
//  Created by Frank Gregor on 17.05.21.
//  Copyright © 2021 Woodbytes. All rights reserved.
//

import Foundation

extension NetService {
    
    public var macAddress: String? {
        txtRecordData()?.txtDictionary["MAC"]
    }
    
    public var uuid: String? {
        if let uuid = txtRecordData()?.txtDictionary["uuid"] {
            return uuid;
        }
        return nil
    }

    open override var description: String {
        var desc: String = "\(name)"
        
        if ipAddresses.indices.contains(0) {
            desc.append(", IPv4: \(ipAddresses[0])")
        }
        if ipAddresses.indices.contains(1) {
            desc.append(", IPv6: \(ipAddresses[1])")
        }

        if let mac = macAddress {
            desc.append(", MAC: \(mac)")
        }

        if let uuid = uuid {
            desc.append(", UUID: \(uuid)")
        }

        return desc
    }
    
}

extension NetService {

    // This code has been found here:
    // https://github.com/teufelaudio/CombineBonjour
    public var ipAddresses: [String] {
        guard let addresses = self.addresses else {
            return []
        }

        return addresses.compactMap {
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))

            $0.withUnsafeBytes { ptr in
                guard let sockaddr_ptr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self) else { return /* ignoe error */ }
                let sockaddr = sockaddr_ptr.pointee
                guard getnameinfo(
                    sockaddr_ptr,
                    socklen_t(sockaddr.sa_len),
                    &hostname,
                    socklen_t(hostname.count),
                    nil,
                    0,
                    NI_NUMERICHOST
                ) == 0
                else { return /* ignore error */ }
            }
            return String(cString: hostname)
        }
    }

}
