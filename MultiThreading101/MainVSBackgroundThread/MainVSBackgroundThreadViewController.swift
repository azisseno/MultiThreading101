//
//  MainVSBackgroundThreadViewController.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class MainVSBackgroundThreadViewController: UIViewController {
    
    lazy var viewConstructor = MainVSBackgroundThreadViewConstructor(
        viewController: self,
        runMainSelector: #selector(didRunOnMainThread),
        runBackgroundSelector: #selector(didRunOnBackgroundThread))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConstructor.setup()
    }
    
    @objc func didRunOnMainThread() {
        print("LOG: didRunOnMainThread: ")
        getDataFromURL()
        
//        DispatchQueue.main.async {
//            self.getDataFromURL()
//        }

    }

    @objc func didRunOnBackgroundThread() {
        print("LOG: didRunOnBackgroundThread: ")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.getDataFromURL()
        }
    }
    
    private func getDataFromURL() {
        
        print("LOG: getDataFromURL Start")
        let url = URL(string: "https://607a4a88bd56a60017ba291c.mockapi.io/users")!
        var dataFromURL: Data!
        do {
            dataFromURL = try Data(contentsOf: url)
        } catch {
            assertionFailure(error.localizedDescription)
        }
        
        print("LOG: getDataFromURL Got it !!")
        
        //let nameList: [String] = getNameListFromJsonData(dataFromURL)

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
