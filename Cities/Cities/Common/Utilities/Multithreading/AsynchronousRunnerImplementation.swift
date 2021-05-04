//
//  AsynchronousRunnerImplementation.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation


open class AsynchronousRunnerImplementation: NSObject, AsynchronousRunner {
    
    public func runOnConcurrent(_ action: @escaping () -> Void, _ qos: DispatchQoS.QoSClass) {
        DispatchQueue.global(qos: qos).async(execute: action)
    }
    
    
    public func runOnMain(_ action: @escaping () -> Void) {
        DispatchQueue.main.async(execute: action)
    }
    
}
