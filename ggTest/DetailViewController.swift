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
    var url1: String = ""
    
    @IBOutlet weak var getIt: UIButton!
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
        url1 = (productList?.url)!
        imageView.image = loadData.decodeBase64ToImage(base64: (productList?.thumbnall)!)
        getIt.addTarget(self, action: "doRequest", for: UIControlEvents.touchUpInside)
        //        sectionName.text = product
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func doRequest(sender: AnyObject) {
        if let url = NSURL(string: url1){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
}

