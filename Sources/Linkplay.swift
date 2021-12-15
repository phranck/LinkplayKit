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
import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

public class Linkplay: NSObject, ObservableObject {
    internal static let version = "0.1.0"
    internal static let build = 1

    internal var browser: NetServiceBrowser?
    internal var services: Set<NetService> = Set()

    public override init() {}

    // MARK: - Public API
    
    @Published public internal(set) var devices: Set<LinkplayDevice> = []
    @Published public var selectedDevice: LinkplayDevice?

    public func isSelected(device: LinkplayDevice) -> Bool {
        return selectedDevice == device
    }
    
}

