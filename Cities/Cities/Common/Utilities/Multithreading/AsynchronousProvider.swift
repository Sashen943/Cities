//
//  AsynchronousProvider.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

import Foundation

public struct AsynchronousProvider {

    private static var asyncRunner : AsynchronousRunner = AsynchronousRunnerImplementation()
    
    /**
     Run a block of code on a concurrent queue.
     
     Concurrent queues (also known as a type of global dispatch queue) execute one or more tasks
     concurrently, but tasks are still started in the order in which they were added to the queue.
     The currently executing tasks run on distinct threads that are managed by the dispatch queue.
     The exact number of tasks executing at any given point is variable and depends on system
     conditions.
     
     - parameter action: Closure to run on concurrent thread.
     */
    public static func runOnConcurrent(_ action: @escaping () -> Void, _ qos: DispatchQoS.QoSClass) {
        asyncRunner.runOnConcurrent(action, qos)
    }
    
    public static func runOnMain(_ action: @escaping () -> Void) {
        asyncRunner.runOnMain(action)
    }

    public static func setAsyncRunner(_ asyncRunner: AsynchronousRunner) {
        self.asyncRunner = asyncRunner
    }
    
    public static func reset() {
        asyncRunner = AsynchronousRunnerImplementation()
    }

}
