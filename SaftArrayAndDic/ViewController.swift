//
//  ViewController.swift
//  SaftArrayAndDic
//
//  Created by hans on 2018/8/30.
//  Copyright © 2018年 hans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func testArray()  {
        // Thread-unsafe array
        do {
            var array = [Int]()
            var iterations = 1000
            let start = Date().timeIntervalSince1970
            
            DispatchQueue.concurrentPerform(iterations: iterations) { index in
                let last = array.last ?? 0
                array.append(last + 1)
                
                DispatchQueue.global().sync {
                    iterations -= 1
                    
                    // Final loop
                    guard iterations <= 0 else { return }
                    let message = String(format: "Unsafe loop took %.3f seconds, count: %d.",
                                         Date().timeIntervalSince1970 - start,
                                         array.count
                    )
                    print(message)
                }
            }
        }
        
        // Thread-safe array
        do {
            var array = SynchronizedArray<Int>()
            var iterations = 1000
            let start = Date().timeIntervalSince1970
            
            DispatchQueue.concurrentPerform(iterations: iterations) { index in
                let last = array.last ?? 0
                array.append(last + 1)
                
                DispatchQueue.global().sync {
                    iterations -= 1
                    
                    // Final loop
                    guard iterations <= 0 else { return }
                    let message = String(format: "Safe loop took %.3f seconds, count: %d.",
                                         Date().timeIntervalSince1970 - start,
                                         array.count)
                    print(message)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

