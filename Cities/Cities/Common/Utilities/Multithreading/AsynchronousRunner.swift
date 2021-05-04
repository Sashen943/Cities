//
//  AsynchronousRunner.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

public protocol AsynchronousRunner {

    func runOnConcurrent(_ action: @escaping () -> Void, _ qos: DispatchQoS.QoSClass)
    
    func runOnMain(_ action: @escaping () -> Void)
    
}

