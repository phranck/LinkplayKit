//
//  Data+Extensions.swift
//
//  Created by Frank Gregor on 22.07.21.
//

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
