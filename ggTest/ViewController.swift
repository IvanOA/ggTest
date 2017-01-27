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
    
    let realm = try! Realm()
    var products: [String] = []
    
    func LoadAllData() {
        var category_list = realm.objects(Category)
        var product_list = realm.objects(Product)
        do {
            if (product_list.isEmpty != nil) {
            category_list = realm.objects(Category)
            for list in category_list {
                for item in list.ProductList {
                    products.append(item.name)
                }
            }
                if (products.isEmpty == nil) {
                    print("Array is empty")
                }
            } else {
                print("no products in database")
            }
        } catch {
            print("Error to load all data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  var categ: Category = Category()
        var loadData: LoadData = LoadData()
        //loadData.LoadCategory()
        LoadAllData()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    func RefreshList(){
        let category_list = self.realm.objects(Category)
        if (category_list.isEmpty != true && products.isEmpty == nil)
        {
        for list in category_list {
            for value in list.ProductList {
                self.products.append(value.name)
                print(value.name + "     в массиве (ревреш)")
            }
            }
        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
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
        var label1 = UILabel()
        label1 = cell.viewWithTag(1) as! UILabel
        label1.text = ""
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
