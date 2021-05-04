//
//  DummyAsynchronousRunner.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

public struct DummyAsynchronousRunner: AsynchronousRunner {

    let beforeRunInBackground: (() -> Void)?
    let beforeRunOnMain: (() -> Void)?

    public init() {
        self.beforeRunInBackground = .none
        self.beforeRunOnMain = .none
    }

    public init(beforeRunInBackground: @escaping () -> Void) {
        self.beforeRunInBackground = beforeRunInBackground
        self.beforeRunOnMain = .none
    }

    public init(beforeRunOnMain: @escaping () -> Void) {
        self.beforeRunInBackground = .none
        self.beforeRunOnMain = beforeRunOnMain
    }

    public init(beforeRunInBackground: @escaping () -> Void, beforeRunOnMain: @escaping () -> Void) {
        self.beforeRunInBackground = beforeRunInBackground
        self.beforeRunOnMain = beforeRunOnMain
    }

    public func runOnConcurrent(_ action: @escaping () -> Void, _ qos: DispatchQoS.QoSClass) {
        beforeRunInBackground?()
        action()
    }

    public func runOnMain(_ action: @escaping () -> Void) {
        beforeRunOnMain?()
        action()
    }

}
