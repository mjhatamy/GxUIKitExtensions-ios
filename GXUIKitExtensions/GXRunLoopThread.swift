//
//  GXThread.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 3/28/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import Foundation

/// FIFO. First-In-First-Out guaranteed on exactly same thread.
open class GXRunLoopThread: Thread {
    
    public typealias ThreadBlock = @convention(block) () -> Void
    
    private let condition = NSCondition()
    private(set) var paused: Bool = false
    
    /**
     Designated initializer.
     - parameters:
     - start: Boolean whether thread should start immediately. Defaults to true.
     - queue: Initial array of blocks to add to enqueue. Executed in order of objects in array.
     */
    public init(start: Bool = true) {
        super.init()
        // Start thread
        if start {
            self.start()
        }
    }
    
    /**
     The main entry point routine for the thread.
     You should never invoke this method directly. You should always start your thread by invoking the start method.
     Shouldn't invoke `super`.
     */
    override open func main() {
        
        // Infinite loops until thread is cancelled
        
        while (!isCancelled ){
            RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
            //LOGD("Run Loop isCancelled:\(isCancelled)")
         }
 
        /*
        // Infinite loops until thread is cancelled
        while true {
            LOGD("RUN LOOP")
            // Use NSCondition. Comments are from Apple documentation on NSCondition
            // 1. Lock the condition object.
            condition.lock()
            
            // 2. Test a boolean predicate. (This predicate is a boolean flag or other variable in your code that indicates whether it is safe to perform the task protected by the condition.)
            // If no blocks (or paused) and not cancelled
            while (queue.count == 0 || paused) && !isCancelled  {
                // 3. If the boolean predicate is false, call the condition object’s wait or waitUntilDate: method to block the thread. Upon returning from these methods, go to step 2 to retest your boolean predicate. (Continue waiting and retesting the predicate until it is true.)
                LOGD("RUN Wait")
                condition.wait()
            }
            // 4. If the boolean predicate is true, perform the task.
            // If your thread supports cancellation, it should check this property periodically and exit if it ever returns true.
            if (isCancelled) {
                condition.unlock()
                return
            }
            
            // As per http://stackoverflow.com/a/22091859 by Marc Haisenko:
            // Execute block outside the condition, since it's also a lock!
            // We want to give other threads the possibility to enqueue
            // a new block while we're executing a block.
            let block = queue.removeFirst()
            condition.unlock()
            // Run block
            LOGD("RUN Block")
            block()
        }
        */
    }
    
    
    /**
     Start the thread.
     - Warning: Don't start thread again after it has been cancelled/stopped.
     - SeeAlso: .start()
     - SeeAlso: .pause()
     */
    final override public func start() {
        // Lock to let all mutations to behaviour obey FIFO
        condition.lock()
        // Unpause. Might be in pause state
        // Start
        super.start()
        // Release from .wait()
        condition.signal()
        // Release lock
        condition.unlock()
    }
    
    /**
     Cancels the thread.
     - Warning: Don't start thread again after it has been cancelled/stopped. Use .pause() instead.
     - SeeAlso: .start()
     - SeeAlso: .pause()
     */
    final override public func cancel() {
        // Lock to let all mutations to behaviour obey FIFO
        condition.lock()
        // Cancel NSThread
        super.cancel()
        // Release from .wait()
        condition.signal()
        // Release lock
        condition.unlock()
    }
    
    /**
     Pause the thread. To completely stop it (i.e. remove it from the run-time), use `.cancel()`
     - Warning: Thread is still runnin,
     - SeeAlso: .start()
     - SeeAlso: .cancel()
     */
    final public func pause() {
        // Lock to let all mutations to behaviour obey FIFO
        condition.lock()
        //
        paused = true
        // Release from .wait()
        condition.signal()
        // Release lock
        condition.unlock()
    }
    
    /**
     Resume the execution of blocks from the queue on the thread.
     - Warning: Can't resume if thread was cancelled/stopped.
     - SeeAlso: .start()
     - SeeAlso: .cancel()
     */
    final public func resume() {
        // Lock to let all mutations to behaviour obey FIFO
        condition.lock()
        //
        paused = false
        // Release from .wait()
        condition.signal()
        // Release lock
        condition.unlock()
    }
    
    /**
     Execute block, used internally for async/sync functions.
     
     - parameter block: Process to be executed.
     */
    @objc public func run(block: ThreadBlock) {
        block()
    }
    
    /**
     Perform block on current thread asynchronously.
     
     - parameter block: Process to be executed.
     */
    open func async(execute: @escaping ThreadBlock) {
        guard Thread.current != self else { return execute() }
        perform(#selector(run(block:)), on: self, with: execute, waitUntilDone: false)
    }
    
    /**
     Perform block on current thread synchronously.
     
     - parameter block: Process to be executed.
     */
    open func sync(execute: @escaping ThreadBlock) {
        guard Thread.current != self else { return execute() }
        perform(#selector(run(block:)), on: self, with: execute, waitUntilDone: true)
    }
    
}
