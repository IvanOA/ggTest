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

    
    @IBOutlet weak var progressView: UIProgressView!
    var loaddata: LoadData = LoadData()
    override func viewDidLoad() {
        super.viewDidLoad()
        loaddata.LoadCategory()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0){
            self.performSegue(withIdentifier: "Starter", sender: nil)
        }
        progressView.setProgress(0, animated: false)
    }

    func updateProgressView() {
        if progressView.progress != 1 {
            self.progressView.progress += 1/80
        } else {
            //            UIView.animateWithDuration(0.4, animations: { () -> Void in self.button.alpha = 1})
            performSegue(withIdentifier: "Starter", sender: nil)
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
