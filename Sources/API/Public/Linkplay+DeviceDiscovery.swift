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

    public func startBrowsing(ofType type: NetServiceDeviceType) {
        browser = NetServiceBrowser()
        browser?.delegate = self
        browser?.schedule(in: .main, forMode: .common)
        browser?.searchForServices(ofType: type)
    }

    public func stopBrowsing() {
        browser?.stop()
        browser?.delegate = nil
        browser?.remove(from: .main, forMode: .common)
        browser = nil
    }

}

extension Linkplay: NetServiceBrowserDelegate {

    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        services.insert(service)
        service.delegate = self
        service.startMonitoring()
        service.schedule(in: .main, forMode: .common)
        service.resolve(withTimeout: 5)
    }

    public func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        services.remove(service)
    }

}

extension Linkplay: NetServiceDelegate {

    public func netServiceWillResolve(_ service: NetService) {
    }

    public func netService(_ service: NetService, didUpdateTXTRecord data: Data) {
        log.debug("netService:didUpdateTXTRecord: \(service.debugDescription)")
//        createOrUpdateDevice(forService: service)
    }

    public func netServiceDidResolveAddress(_ service: NetService) {
        log.debug("netServiceDidResolveAddress: \(service.debugDescription)")
        createOrUpdateDevice(forService: service)
    }

    public func netServiceDidStop(_ service: NetService) {
    }

}
