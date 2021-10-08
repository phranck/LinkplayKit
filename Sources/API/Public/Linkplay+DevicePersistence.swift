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

extension Linkplay {

    public func createOrUpdateDevice(forService service: NetService) {
        let newDevice = LinkplayDevice(netService: service, api: self)
        newDevice.api = self
        devices.update(with: newDevice)
    }

    public func device(forService service: NetService) -> LinkplayDevice? {
        let searchDevice = LinkplayDevice(netService: service, api: self)
        let result = devices.filter { device in
            return device == searchDevice
        }

        if result.isSubset(of: devices) {
            return result.first
        }

        return nil
    }

    public func removeDevice(forService service: NetService) -> LinkplayDevice? {
        if let device = device(forService: service) {
            devices.remove(device)
            services.remove(service)
            service.stopMonitoring()
            return device
        }

        return nil
    }

}
