//
//  Utils.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import Alamofire

class Utils: NSObject {
    class func convertToParameters(_ object: Encodable) -> Parameters? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(object)
            if let parameters = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Parameters {
                return parameters
            }
        } catch {
            print("Error converting SavePrescriptionForm to parameters: \(error)")
        }
        return nil
    }
}
