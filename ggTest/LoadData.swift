//
//  LoadData.swift
//  ggTest
//
//  Created by Иван on 25.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import RealmSwift

class LoadData {
    let realm = try! Realm()
    var category: Category = Category()
    func LoadCategory() {
        category.id = 01
        category.name = "Game"
        LoadProduct(categ: category.name)
        try! realm.write {
            realm.add(category)
        }
    }
    func LoadProduct(categ: String) {
        var category: Category = Category()
        var product: Product = Product()
        product.id = 0
        product.upvotes = 2
        product.name = "Resident"
        product.url = "www.res.com"
        category.ProductList.append(product)
        var product1: Product = Product()
        product1.id = 1
        product1.upvotes = 5
        product1.name = "Ring"
        product1.url = "www.ring.com"
        category.ProductList.append(product1)
        try! realm.write {
            realm.add(category)
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
