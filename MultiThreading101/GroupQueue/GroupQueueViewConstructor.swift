//
//  GroupQueueViewConstructor.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class GroupQueueViewConstructor: NSObject {
    
    private weak var viewController: GroupQueueViewController!
    private let addTaskSelector: Selector!
    private var titleList: [String] = []
    
    init(viewController: GroupQueueViewController,
         addTaskSelector: Selector) {
        self.viewController = viewController
        self.addTaskSelector = addTaskSelector
    }
    
    func setList(_ titleList: [String]) {
        self.titleList = titleList
        tableView.reloadData()
    }
    
    func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        viewController.view.backgroundColor = .white
        viewController.view.addSubview(headerView)
        viewController.view.addSubview(tableView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addTaskButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5).isActive = true
        addTaskButton.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        addTaskButton.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        addTaskButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

    }
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Task Button", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(viewController, action: self.addTaskSelector, for: .touchUpInside)
        return button
    }()

    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        headerView.addSubview(addTaskButton)
        return headerView
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
}

extension GroupQueueViewConstructor: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titleList[indexPath.row]
        return cell
    }
}
