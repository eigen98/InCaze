//
//  Encodable+asDictionary.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
//FireStore 데이터 매핑
extension Encodable {
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}
