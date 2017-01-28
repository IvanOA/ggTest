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
    
    var imageView = UIImage()
    var loaddata: LoadData = LoadData()
    @IBOutlet weak var bn: UIBarButtonItem!
    let realm = try! Realm()
    //var listPro = List<Product>()
    var products: [String] = []
    var description_list: [String] = []
    var image_list: [UIImage] = []
    var votes_list: [Int] = []
    var id: Int = 1
    var product_id: [Int] = []
    var productName = UILabel()
    var productDescription = UILabel()
    var productVotes = UILabel()
    func LoadAllData() {
        
        print("Loading ALL data")
        var category_list = realm.objects(Category)
        var product_list = realm.objects(Product)
        
        for list in category_list {
            print("Loading data")
            if (list.id == id) {
                print("Loading \(list.id) data")
                for item in list.ProductList {
                    product_id.append(item.id)
                    description_list.append(item.discription!)
                    products.append(item.name)
                    votes_list.append(item.upvotes)
                    imageView = loaddata.decodeBase64ToImage(base64: item.thumbnall!)
                    image_list.append(imageView)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  var categ: Category = Category()
        //var loadData: LoadData = LoadData()
        //loadData.LoadCategory()
        LoadAllData()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
//    @IBAction func bnClicked(sender: AnyObject) {
//        print("Buttons clicked")
//        performSegue(withIdentifier: "Category", sender: nil)
//    }
    
    
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        productName = cell.viewWithTag(1) as! UILabel
        productDescription = cell.viewWithTag(2) as! UILabel
        productVotes = cell.viewWithTag(3) as! UILabel
        productName.text = products[indexPath.row]
        productDescription.text = description_list[indexPath.row]
        productVotes.text = String(votes_list[indexPath.row])
        cell.imageView?.image = image_list[indexPath.row]
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let destVC: DetailViewController = segue.destination as! DetailViewController
                destVC.product = products[indexPath.row]
                destVC.id_product = product_id[indexPath.row]
            }
        }
    }
}
