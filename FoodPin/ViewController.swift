//
//  ViewController.swift
//  FoodPin
//
//  Created by WuQiang on 2017/3/15.
//  Copyright © 2017年 AppCoda. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
}
