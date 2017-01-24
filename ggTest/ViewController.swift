//
//  ViewController.swift
//  ggTest
//
//  Created by Иван on 24.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON


class ViewController: UITableViewController {
    
//    var loadData: LoadData = LoadData()
    
    var products: [String] = ["Section 1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let destVC: DetailViewController = segue.destination as! DetailViewController
                destVC.product = products[indexPath.row]
            }
        }
    }
}
