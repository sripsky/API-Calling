//
//  ViewController.swift
//  API Calling
//
//  Created by Sydney Ripsky on 2/3/20.
//  Copyright © 2020 Sydney Ripsky. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    var properties = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Properties"
        let query = "https://swapi.co/api/starships/schema"
        if let url = URL(string: query) {
             if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                   parse(json: json)
                   return
                }
          }
          loadError()
    }
    func parse(json: JSON) {
        for result in json["properties"].arrayValue {
            let name = result["name"].stringValue
            let length = result["length"].stringValue
            let passengers = result["passenger"].stringValue
            let pilots = result["pilots"].stringValue
            let property = ["name" : name, "length" : length, "passengers" : passengers, "pilots": pilots]
            properties.append(property)
        }
        tableView.reloadData()
    }
    func loadError() {
         let alert = UIAlertController(title: "Loading Error",
                                     message: "There was a problem loading the news feed",
                              preferredStyle: .actionSheet)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil) }
}


