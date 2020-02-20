//
//  ViewController.swift
//  API Calling
//
//  Created by Sydney Ripsky on 2/3/20.
//  Copyright © 2020 Sydney Ripsky. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    var datas = [[String: String]] ()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "datas"
        let query = "https://www.balldontlie.io/api/v1/players"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON) {
        for result in json["data"].arrayValue {
            let id = result["id"].stringValue
            let first_name = result["first_name"].stringValue
            let height_feet = result["height_feet"].stringValue
            let last_name = result["last_name"].stringValue
            let data = ["id" : id, "first_name" : first_name, "height_feet" : height_feet, "last_name" : last_name]
            datas.append(data)
        }
        tableView.reloadData()
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in self.tableView.reloadData()
        }
        
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the news feed",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil) }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = datas[indexPath.row]
        cell.textLabel?.text = data["id"]
        cell.detailTextLabel?.text = data["height_feet"]
        cell.detailTextLabel?.text = data["last_name"]
        cell.detailTextLabel?.text = data["first_name"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PlayersViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.data = [datas[index!]]
        
    }
    @IBAction func onTappedButtonDone(_ sender: Any) { exit(0)
    }
}



