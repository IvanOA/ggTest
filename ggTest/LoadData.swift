//
//  LoadData.swift
//  ggTest
//
//  Created by Иван on 25.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import UIKit
import SwiftyJSON

class LoadData {
    let realm = try! Realm()
    var category: Category = Category()
    func LoadCategory() {
        print("start loading categories")
        var url1: String = "https://api.producthunt.com/v1/categories?access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        var categ = realm.objects(Category)
        if (categ.isEmpty == nil) {
            print("DB is empty")
        }
        Alamofire.request(url1).validate().responseJSON { response in
            print("alamofire started")
            switch response.result {
                
            case .success:
                print("loading categories")
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_,subJson):(String, JSON) in json["categories"]{
                        var category1: Category = Category()
                        category1.id = subJson["id"].intValue
                        category1.name = subJson["name"].stringValue
                        category1.teg = subJson["slug"].stringValue
                        print("1 element added with id \(category1.id)")
                        try! self.realm.write {
                            self.realm.add(category1, update: true)
                            
                        }
                        
                    }
//                    try! self.realm.write {
//                        self.realm.add(self.category_list, update: true)
//                        
//                    }
                    print("loaded categories")
                }
            case .failure(let error):
                print("failed to load categories")
                print(error)
            }
        }
        
    }
    func LoadProduct(categ: String) {
        //let utilityQueue = DispatchQueue.global(qos: .utility)
        var url2: String = "https://api.producthunt.com/v1/posts/all?search[category]=tech&access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        Alamofire.request(url2).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                   // var category: Category = Category()
                    for (_,subJson):(String, JSON) in json["posts"]{
                        var product: Product = Product()
                        var category: Category = Category()
                        product.id = subJson["id"].intValue
                        product.upvotes = subJson["votes_count"].intValue
                        product.name = subJson["name"].stringValue
                        product.categ_id = subJson["categ_id"].intValue
                        product.url = subJson["redirect_url"].stringValue
                        category.ProductList.append(product)
                        
                    }
                   
                    try! self.realm.write {
                        self.realm.add(self.category, update: true)
                        for list in self.category.ProductList {
                            print(list.name)
                            }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    func CategoryLoadDB() -> Results<Category>{
        let last_data = self.realm.objects(Category).filter("name")
        return last_data
    }
    func ProductLoadDB() -> Results<Product>{
        let last_data = self.realm.objects(Product).filter("name")
        print(last_data)
        return last_data
    }
    func ProductClear(){
        //let last_data = self.realm.objects(Product)
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}
