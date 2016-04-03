//
//  RACHelpers.swift
//  RWTFlickrSearch
//
//  Created by Boyan Yankov on W13 03/04/2016 Sun.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import Foundation
import ReactiveCocoa

// MARK: - `RAC` macro swift replacement

public struct RAC {
    var target : NSObject
    var keyPath : String
    var nilValue : AnyObject?
    
    init(_ target: NSObject, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

// MARK: - Operators

// RAC(myObject, "someProperty") <~ someSignal

infix operator <~ {}
public func <~ (rac: RAC, signal: RACSignal) {
    rac.assignSignal(signal)
}

// someSignal ~> RAC(myObject, "someProperty")

infix operator ~> {}
public func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}

// MARK: - `RACObserve` macro swift replacement

//public func RACObserve(target: NSObject, _ keyPath: String) -> RACSignal {
//    return target.rac_valuesForKeyPath(keyPath, observer: target)
//}

extension NSObject {
    func RACObserve(target: NSObject!, _ keyPath: String) -> RACSignal{
        return target.rac_valuesForKeyPath(keyPath, observer: target)
    }
}