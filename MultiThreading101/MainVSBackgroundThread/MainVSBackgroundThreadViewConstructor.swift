//
//  MainVSBackgroundThreadDataSource.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class MainVSBackgroundThreadViewConstructor: NSObject {
    
    private let runMainSelector: Selector
    private let runBackgroundSelector: Selector
    private weak var viewController: MainVSBackgroundThreadViewController!
    
    public var overrideList: [String]?
    
    init(viewController: MainVSBackgroundThreadViewController, runMainSelector: Selector, runBackgroundSelector: Selector) {
        
        self.viewController = viewController
        self.runMainSelector = runMainSelector
        self.runBackgroundSelector = runBackgroundSelector
    }
    
    func setup() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        viewController.view.backgroundColor = .white
        viewController.view.addSubview(headerView)
        viewController.view.addSubview(tableView)

        setupConstraint()
    }
    
    private func setupConstraint() {
        headerView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        runMainButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5).isActive = true
        runMainButton.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        runMainButton.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        runMainButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        runBackgroundButton.topAnchor.constraint(equalTo: runMainButton.bottomAnchor).isActive = true
        runBackgroundButton.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        runBackgroundButton.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        runBackgroundButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private lazy var longStringList: [String] = {
        var array: [String] = []
        for i in 1...1000 {
            array.append("List Number: \(i)")
        }
        return array
    }()
    
    private weak var runMainButton: UIButton!
    private weak var runBackgroundButton: UIButton!
    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        
        let runMainButton = UIButton()
        runMainButton.translatesAutoresizingMaskIntoConstraints = false
        runMainButton.setTitle("Request On Main", for: .normal)
        runMainButton.setTitleColor(.blue, for: .normal)
        runMainButton.addTarget(viewController, action: self.runMainSelector, for: .touchUpInside)
        headerView.addSubview(runMainButton)
        self.runMainButton = runMainButton
        
        let runBackgroundButton = UIButton()
        runBackgroundButton.translatesAutoresizingMaskIntoConstraints = false
        runBackgroundButton.setTitle("Request On Background", for: .normal)
        runBackgroundButton.setTitleColor(.blue, for: .normal)
        runBackgroundButton.addTarget(viewController, action: self.runBackgroundSelector, for: .touchUpInside)
        headerView.addSubview(runBackgroundButton)
        self.runBackgroundButton = runBackgroundButton

        return headerView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

}

extension MainVSBackgroundThreadViewConstructor: UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let overrideList = overrideList, overrideList.count > 0 {
            return overrideList.count
        }
        return longStringList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var text = longStringList[indexPath.row]
        if let overrideList = overrideList, overrideList.count > 0 {
            text = overrideList[indexPath.row]
        }
        cell.textLabel?.text = text
        return cell
    }

}
