//
//  RandomNumbers.swift
//  Runner
//
//  Created by Muhammad Salman on 19/07/2023.
//

import Foundation
import Flutter

enum Methods: String {
    case GENERATE = "generate"
}

let ranGenerator = RandomNumbers()

func randomNumbersOnMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let mode = Methods(rawValue: call.method)
    switch mode {
        case .GENERATE:
            ranGenerator.generate(call, result)
        default:
            result(FlutterMethodNotImplemented)
                return
    }
}

class RandomNumbers {
    
    func generate(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let userRange = ((call.arguments as? Dictionary<String, Any>)?["range"] as? Int ?? 100)

        if userRange > 100 {
            result(FlutterError(code: "Out of range", message: "Currently we dont support > 100", details: nil))
        } else {
            let ranNum = Int.random(in: 0...userRange)
            result(["ran": ranNum, "rangeStart": 0, "rangeEnd": userRange])
        }
    }

}
