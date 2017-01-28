//
//  DetailViewController.swift
//  ggTest
//
//  Created by Иван on 25.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import RealmSwift
class DetailViewController: UIViewController {
    var realm = try! Realm()
    var loadData: LoadData = LoadData()
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var votesProduct: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
    var id_product: Int = 0
    var product: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product
        var productList = self.realm.objects(Product).filter("id == \(id_product)").first
        votesProduct.text = String(describing: (productList?.upvotes)! as Int)
        descriptionProduct.text = "About: \(productList?.discription)"
        imageView.image = loadData.decodeBase64ToImage(base64: (productList?.thumbnall)!)
        //        sectionName.text = product
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
