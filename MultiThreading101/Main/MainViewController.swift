//
//  MainViewController.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class MainViewController: UITableViewController {
    
    struct ListElement {
        let title: String
        let page: String
    }

    private lazy var elements: [ListElement] = createElemnents()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = elements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = elements[indexPath.row]
        if let viewControlerType = Bundle.main.classNamed("MultiThreading101.\(list.page)") as? UIViewController.Type {
            let viewController = viewControlerType.init()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            assertionFailure("\(list.page) ViewController Not Found")
        }

    }

}
