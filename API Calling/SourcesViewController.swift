//
//  ViewController.swift
//  API Calling
//
//  Created by Sydney Ripsky on 2/3/20.
//  Copyright © 2020 Sydney Ripsky. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
     var sources = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Wars Starships"
        let query = "https://swapi.co/api/starships/schema"
    }


}

