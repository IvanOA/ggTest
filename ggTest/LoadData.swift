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
        var url2: String = "https://api.producthunt.com/v1/posts/all?search[category]=games&access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        Alamofire.request(url2).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    // var category: Category = Category()
                    for (_,subJson):(String, JSON) in json["posts"]{
                        var product: Product = Product()
                        product.id = subJson["id"].intValue
                        product.upvotes = subJson["votes_count"].intValue
                        product.name = subJson["name"].stringValue
                        product.url = subJson["redirect_url"].stringValue
                        self.category.ProductList.append(product)
                        
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
//        var category_list = realm.objects(Category)
//        var product_list = realm.objects(Product)
       // if (category_list.isEmpty == nil) {
        category.id = 01
        category.name = "Game"
        
       // if (product_list.isEmpty == nil) {
            LoadProduct(categ: category.name)
       // }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
        try! self.realm.write {
            self.realm.add(self.category)
            }
        }
    //}
    }
    func LoadProduct(categ: String) {
        //let utilityQueue = DispatchQueue.global(qos: .utility)
        var url2: String = "https://api.producthunt.com/v1/posts/all?search[category]=games&access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        Alamofire.request(url2).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                   // var category: Category = Category()
                    for (_,subJson):(String, JSON) in json["posts"]{
                        var product: Product = Product()
                        product.id = subJson["id"].intValue
                        product.upvotes = subJson["votes_count"].intValue
                        product.name = subJson["name"].stringValue
                        product.url = subJson["redirect_url"].stringValue
                        self.category.ProductList.append(product)
                        
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
