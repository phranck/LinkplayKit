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

// MARK: NetService related
// MARK: -

extension Data {
    public var txtDictionary: [String: String] {
        var dict: [String: String] = [:]
        
        let txtRecord = NetService.dictionary(fromTXTRecord: self)
        for (key, data) in txtRecord {
            if let line = NSString(data:data, encoding:String.Encoding.utf8.rawValue) {
                dict[key] = line as String
            }
            else {
                dict[key] = data.description
            }
        }
        
        return dict
    }
}

// MARK: - LinkPlay API Response related
// MARK: -

extension Data {
    public var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined().uppercased()
    }
}
