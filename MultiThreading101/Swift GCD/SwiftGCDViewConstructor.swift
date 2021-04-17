//
//  SwiftGCDViewConstructor.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class SwiftGCDViewConstructor: NSObject {
    
    private let actionList: [(String, Selector)]
    private weak var viewController: SwiftGCDViewController!
    private weak var tableView: UITableView!

    init(viewController: SwiftGCDViewController,
         actionList: [(String, Selector)]) {
        self.viewController = viewController
        self.tableView = viewController.tableView
        self.actionList = actionList
    }
    
    func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SwiftGCDViewConstructor: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let action = actionList[indexPath.row]
        cell.textLabel?.text = action.0
        return cell
    }
    
    //MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actionList[indexPath.row]
        viewController.perform(action.1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
