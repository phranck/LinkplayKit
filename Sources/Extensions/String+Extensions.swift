//
//  String+LinkPlay.swift
//
//  Created by Frank Gregor on 22.07.21.
//

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
        for i in 0 ..< length {
            let j = self.index(self.startIndex, offsetBy: i * 2)
            let k = self.index(j, offsetBy: 2)
            let bytes = self[j..<k]
            if var byte = UInt8(bytes, radix: 16) {
                data.append(&byte, count: 1)
            } else {
                return nil
            }
        }
        return data
    }

}
