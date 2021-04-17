//
//  DispatchWorkItemViewController.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class DispatchWorkItemViewController: UIViewController {
    
    weak var searchBar: UISearchBar!
    
    lazy var viewConstructor: DispatchWorkItemViewConstructor = {
        let constructor = DispatchWorkItemViewConstructor(viewController: self)
        return constructor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = viewConstructor.setup()
        searchBar.delegate = self
    }
    
    var searchingWorkItem: DispatchWorkItem?
    
    private func performSearch(keyword: String) {
        
        print("LOG: performSearch: \(keyword)")
        
        searchingWorkItem?.cancel()
        
        // kalau pakai nssession,
        // sessionnya bisa d cancel
        
        searchingWorkItem = DispatchWorkItem(block: { [weak self] in
            // kalau disini uda start..
            guard !keyword.isEmpty else { return }
            self?.requestWithNameLike(keyword) // <-- bs dicancel
        })

        let queue = DispatchQueue(label: "com.azisseno.MultiThreading101.DispatchWorkItemViewController.Search")

        queue.sync(execute: searchingWorkItem) {
            // task ini bs
        }
        queue.asyncAfter(deadline: DispatchTime.now() + 2, execute: searchingWorkItem!)

    }
    
    func requestWithNameLike(_ keyword: String) {
        print("LOG: getDataFromURL")
        let url = URL(string: "https://607a4a88bd56a60017ba291c.mockapi.io/users?name=\(keyword)")!
        var dataFromURL: Data!
        do {
            dataFromURL = try Data(contentsOf: url)
        } catch {
            assertionFailure(error.localizedDescription)
        }
        
        print("LOG: \(getNameListFromJsonData(dataFromURL))")

    }
    
    private func getNameListFromJsonData(_ data: Data) -> [String] {
        
        var nameList: [String] = []
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                for json in jsonArray {
                    if let json = json as? [String: Any],
                       let name = json["name"] as? String {
                        nameList.append(name)
                    }
                }
            }
        } catch let error as NSError {
            assertionFailure("Failed to load: \(error.localizedDescription)")
        }

        return nameList
    }

}

extension DispatchWorkItemViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(keyword: searchText)
    }
}
