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
