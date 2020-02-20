//
//  PlayersViewController.swift
//  API Calling
//
//  Created by Sydney Ripsky on 2/13/20.
//  Copyright © 2020 Sydney Ripsky. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    var data = [[String: String]]()
    var playerDatas = [[String:String]] ()
    var playerData = [String: String]()
    
    @IBOutlet weak var playerIdTextfield: UITextField!
    @IBOutlet weak var playerFirstNameTextfield: UITextField!
    @IBOutlet weak var playerLastNameTextfield: UITextField!
    @IBOutlet weak var playerHeightFeetTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "datas"
        let query = "https://www.balldontlie.io/api/v1/players"
        //DispatchQueue.global(qos: .userInitiated).async {
        //    [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    self.displayplayerData()
                    return
                }
            }
            self.loadError()
        //}
    }
    
    func parse(json: JSON) {
        for result in json["data"].arrayValue {
            let id = result["id"].stringValue
           let first_name = result["first_name"].stringValue
            let height_feet = result["height_feet"].stringValue
            let last_name = result["last_name"].stringValue
            playerData = ["id" : id, "first_name" : first_name, "height_feet" : height_feet, "last_name" : last_name]
            self.displayplayerData()
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
    
    @IBAction func onTappedButtonDone(_ sender: Any) { exit(0)
    }
    
    func displayplayerData() {
        playerIdTextfield.text = playerData["id"]
        playerFirstNameTextfield.text = playerData["first_name"]
        playerHeightFeetTextfield.text = playerData["height_feet"]
        playerLastNameTextfield.text = playerData["last_name"]
    }
}

