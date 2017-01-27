//
//  Categories.swift
//  ggTest
//
//  Created by Иван on 27.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import RealmSwift

class Categories: UITableViewController {
    let realm = try! Realm()
    var categories: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered category-switcher")
        var category_list = realm.objects(Category)
        for item in category_list {
            categories.append(item.name)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCateg = tableView.dequeueReusableCell(withIdentifier: "cellCateg", for: indexPath) as UITableViewCell
//        var label1 = UILabel()
//        label1 = cell.viewWithTag(1) as! UILabel
//        label1.text = ""
        cellCateg.textLabel?.text = categories[indexPath.row]
        
        return cellCateg
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Main"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
//                let destVC: DetailViewController = segue.destination as! DetailViewController
//                destVC.product = products[indexPath.row]
            }
        }
    }


}
