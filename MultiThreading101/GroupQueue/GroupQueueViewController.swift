//
//  GroupQueueViewController.swift
//  MultiThreading101
//
//  Created by Azis Senoaji Prasetyotomo on 17/4/21.
//

import UIKit

class GroupQueueViewController: UIViewController {
    
    var titleList: [String] = []
    
    lazy var viewConstructor: GroupQueueViewConstructor = {
        return GroupQueueViewConstructor(
            viewController: self,
            addTaskSelector: #selector(addTask))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConstructor.setup()
        
    }
        
    var number: Int = 1
    @objc private func addTask() {
        
        requestUserWithID("\(number + 1)")
        number += 1
        
    }
    
    var groupOfUserRequest = DispatchGroup()
    
    private func requestUserWithID(_ id: String) {
        let queue = DispatchQueue(label: "com.azisseno.GroupQueueViewController.requestUserID.\(id)", attributes: .concurrent)
        queue.async(group: groupOfUserRequest) { [weak self] in
            guard let data = self?.getUserDataWithID(id) else { return }
            guard let jsonDict = self?.getSimpleJSONObject(data) else { return }
            self?.titleList.append("id: \(jsonDict["id"]!), name: \(jsonDict["name"]!)")
            
            
        }
        
        groupOfUserRequest.notify(queue: DispatchQueue.main) { [weak self] in
            guard let titleList = self?.titleList else { return }
            self?.viewConstructor.setList(titleList)
        }

    }
    
    private func getUserDataWithID(_ id: String) -> Data! {
        let url = URL(string: "https://607a4a88bd56a60017ba291c.mockapi.io/users/\(id)")!
        do {
            return try Data(contentsOf: url)
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
    
    private func getSimpleJSONObject(_ data: Data) -> [String: String] {
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let id = json["id"] as? String,
                   let name = json["name"] as? String {
                    return [
                        "id": id,
                        "name": name
                    ]
                }
            }
        } catch let error as NSError {
            assertionFailure("Failed to load: \(error.localizedDescription)")
        }
        
        return [:]

    }

}
