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
    var i: Int = 0
    var category: Category = Category()
    func LoadCategory() {
        print("start loading categories")
        var url1: String = "https://api.producthunt.com/v1/categories?access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        
        
        Alamofire.request(url1).validate().responseJSON { response in
            print("alamofire started")
            switch response.result {
                
            case .success:
                print("loading categories")
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_,subJson):(String, JSON) in json["categories"]{
                        var categ_list = self.realm.objects(Category).filter("id == \(subJson["id"].intValue)").first
                        if (categ_list == nil) {
                        var category1: Category = Category()
                        category1.id = subJson["id"].intValue
                        category1.name = subJson["name"].stringValue
                        category1.teg = subJson["slug"].stringValue
                        print("1 element added with id \(category1.id)")
                        try! self.realm.write {
                            self.realm.add(category1, update: true)
                        }
                            self.LoadProduct(categ: subJson["slug"].stringValue)
                        print(subJson["slug"].stringValue)
                        } else {
                            print("category is in a database")
                        }
                    }
                    print("loaded categories")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func LoadProduct(categ: String) {
        var flag = false
        print("start loading products for \(categ)")
        //let utilityQueue = DispatchQueue.global(qos: .utility)
        var url2: String = "https://api.producthunt.com/v1/posts/all?search[category]=\(categ)&access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        Alamofire.request(url2).validate().responseJSON { response in
            print("starting alamofire")
            switch response.result {
            case .success:
                print("loading products")
                if let value = response.result.value {
                    let json = JSON(value)
                   // var category: Category = Category()
                    for (_,subJson):(String, JSON) in json["posts"]{
                        var img = UIImage()
                        var product: Product = Product()
                        var category0 = self.realm.objects(Category)
                        for item in category0 {
                            print(item.teg)
                        }
                        var categ_list = self.realm.objects(Category).filter("teg == '\(categ)'").first
                        var productList = self.realm.objects(Product).filter("id == \(subJson["id"].intValue)").first
                        
                            if (productList == nil && product.id != 89137) {
                                product.id = subJson["id"].intValue
                                product.upvotes = subJson["votes_count"].intValue
                                product.name = subJson["name"].stringValue
                                product.discription = subJson["tagline"].string
                                product.categ_id = subJson["category_id"].intValue
                                product.url = subJson["redirect_url"].stringValue
                                img = self.LoadImageUrl(path: subJson["thumbnail"]["image_url"].string!)!
                                product.thumbnall = self.encodeImageToBase64(image: img)
                                try! self.realm.write {
                                    categ_list!.ProductList.append(product)
                                    self.i = self.i + 1
                                    print(self.i)
                                }
                                
                            }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func LoadImageUrl(path: String) -> UIImage? {
        let url = NSURL(string: path)
        let data = NSData(contentsOf: url as! URL)
        let img = UIImage (data: data as! Data)
        return img
    }
    func encodeImageToBase64(image : UIImage) -> String{
        
        let imageData : Data = UIImagePNGRepresentation(image)! as Data
        let strBase64 = imageData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        return strBase64
    }
    
    func decodeBase64ToImage(base64 : String) -> UIImage{
        
        let dataDecoded : NSData = NSData(base64Encoded: base64, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage : UIImage = UIImage(data: dataDecoded as Data)!
        return decodedimage
    }
    func ProductClear(){
        //let last_data = self.realm.objects(Product)
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}
