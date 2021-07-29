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

extension String {

    // MARK: LinkPlay API Response related
    // MARK: -

    public var asciiFromHexString: String? {
        if let data = self.dataFromHexString,
            let ascii = String(bytes: data, encoding: .utf8) {
            return ascii
        }
        return nil
    }
    
    public var hexStringFromASCII: String? {
        if let data = self.data(using: .utf8) {
            return data.hexString
        }
        return nil
    }
    
    public var dataFromHexString: Data? {
        let length = self.count / 2
        var data = Data(capacity: length)
        for idx in 0 ..< length {
            let startIndex = self.index(self.startIndex, offsetBy: idx * 2)
            let k = self.index(startIndex, offsetBy: 2)
            let bytes = self[startIndex..<k]
            if var byte = UInt8(bytes, radix: 16) {
                data.append(&byte, count: 1)
            } else {
                return nil
            }
        }
        return data
    }

}
