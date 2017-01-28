//
//  LaunchVCViewController.swift
//  ggTest
//
//  Created by Иван on 27.01.17.
//  Copyright © 2017 Иван. All rights reserved.
//
import Foundation
import RealmSwift
import UIKit

class LaunchViewController: UIViewController {

    var loaddata: LoadData = LoadData()
    override func viewDidLoad() {
        super.viewDidLoad()

        loaddata.LoadCategory()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0){
            self.performSegue(withIdentifier: "Starter", sender: nil)
        }
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
