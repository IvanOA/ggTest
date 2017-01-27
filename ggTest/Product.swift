//
//  Product.swift
//  ggTest
//
//  Created by Иван on 25.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    var ProductList = List<Product>()
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var teg: String = ""
    override static func primaryKey() -> String?{
        return "id"
    }
}
class Product: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var categ_id: Int = 0
    dynamic var upvotes: Int = 0
    dynamic var discription: String? = nil
    dynamic var thumbnall: String? = nil
    dynamic var url: String = ""
    dynamic var image: String? = nil
    override static func primaryKey() -> String?{
        return "id"
    }
}
