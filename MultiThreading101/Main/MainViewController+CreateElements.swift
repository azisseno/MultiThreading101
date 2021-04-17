//
//  MainViewController+CreateElements.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

extension MainViewController {
    
    func createElemnents() -> [ListElement] {
        return [
            ListElement(title: "Swift GCD",
                        page: "SwiftGCDViewController"),
            ListElement(title: "Main vs Background Thread",
                        page: "MainVSBackgroundThreadViewController"),
            ListElement(title: "Group Queue",
                        page: "GroupQueueViewController"),
            ListElement(title: "Dispatch Work Item",
                        page: "DispatchWorkItemViewController"),
        ]
    }
    
}
