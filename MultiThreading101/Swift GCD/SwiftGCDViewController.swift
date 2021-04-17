//
//  SwiftGCDViewController.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class SwiftGCDViewController: UITableViewController {

    private let actionList: [(String, Selector)] = [
        ("Synchronous", #selector(synchronousDemo)),
        ("Asynchronous", #selector(asynchronousDemo)),
        ("Nested Queue", #selector(nestedQueueDemo)),
        ("Main Queue", #selector(mainQueueDemo)),
        ("Background Queue", #selector(backgroundQueueDemo)),
        ("Custom Queue", #selector(customQueueDemo)),
        ("Serial Queue", #selector(serialQueueDemo)),
        ("Concurrent Queue", #selector(concurrentQueueDemo)),
        ("Dispatch Group", #selector(dispatchGroupDemo)),
        ("Quality of Services", #selector(qosDemo))
    ]

    lazy var viewConstructor: SwiftGCDViewConstructor = {
        return SwiftGCDViewConstructor(
            viewController: self,
            actionList: actionList)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConstructor.setup()
    }
    
    @objc func synchronousDemo() {
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.synchronousDemo")
        queue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1")
        }
        queue.sync {
            print("LOG: Task 2")
        }
    }
    
    @objc func asynchronousDemo() {
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.asynchronousDemo")
        
        queue.async {
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1")
        }
        
        print("LOG: Task 2")
        
    }
    
    @objc func nestedQueueDemo() {
        
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.nestedQueueDemo")
        let queue2 = DispatchQueue(label: "com.azisseno.MultiThreading101.nestedQueueDemo2")

        queue.async {
            print("LOG: Task 1 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1 finished")

            queue2.async {
                print("LOG: Task 3")
            }
        }

        print("LOG: Task 2")

    }
    
    @objc func mainQueueDemo() {
        
        DispatchQueue.main.async {
            print("LOG: Task 1")
        }
    }
    
    @objc func backgroundQueueDemo() {
        
        DispatchQueue.global().async {
            print("LOG: Request API start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Request API fininshed")

            DispatchQueue.main.async {
                print("LOG: Reload View")
            }

        }
    }
    
    @objc func customQueueDemo() {
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.customQueueDemo")
        
    }
    
    @objc func serialQueueDemo() {
        
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.serialQueueDemo")
        queue.sync {
            print("LOG: Task 1 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1 finish")
        }
        
        queue.async {
            print("LOG: Task 2 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 2 finish")
        }
        
        queue.async {
            print("LOG: Task 3 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 3 fininsh")
        }


    }
    
    @objc func concurrentQueueDemo() {
        
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.serialQueueDemo", attributes: .concurrent)

        queue.async {
            print("LOG: Task 1 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1 finish")
        }
        
        queue.async {
            print("LOG: Task 2 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 2 finish")
        }
        
        queue.async {
            print("LOG: Task 3 start")
            Thread.sleep(forTimeInterval: 2)
            print("LOG: Task 3 fininsh")
            
        }
        
        // total method exec = 2 second

    }
    
    @objc func dispatchGroupDemo() {
        
        let queueGroup = DispatchGroup()
        
        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.queue1", attributes: .concurrent)
        
        queue.async(group: queueGroup) {
            print("LOG: Task 1 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 1 finish")
        }

        queue.async(group: queueGroup) {
            print("LOG: Task 2 start")
            Thread.sleep(forTimeInterval: 1)
            print("LOG: Task 2 finish")
        }
        
        queue.async(group: queueGroup) {
            print("LOG: Task 3 start")
            Thread.sleep(forTimeInterval: 2)
            print("LOG: Task 3 fininsh")
            
        }
        
        let queue2 = DispatchQueue(label: "com.azisseno.MultiThreading101.queue2", attributes: .concurrent)

        let queue3 = DispatchQueue(label: "com.azisseno.MultiThreading101.queue2", attributes: .concurrent)

        queueGroup.notify(queue: queue3) {
            print("LOG: All tasks finished")
        }
    }
    
    @objc func qosDemo() {
        
    }

}
