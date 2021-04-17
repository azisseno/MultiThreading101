//
//  DispatchDelayViewConstructor.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class DispatchWorkItemViewConstructor: NSObject {
    
    private weak var viewController: UIViewController!
        
    init(viewController: DispatchWorkItemViewController) {
        self.viewController = viewController
    }
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "READY"
        return label
    }()
    
    func setup() -> UISearchBar {
        let searchController = UISearchController(searchResultsController: nil)
        viewController.navigationItem.searchController = searchController
        viewController.view.backgroundColor = .white
        viewController.view.addSubview(centerLabel)
        
        setupConstraint()
        
        return searchController.searchBar
    }
    
    private func setupConstraint() {
        centerLabel.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: -80).isActive = true

    }
}

