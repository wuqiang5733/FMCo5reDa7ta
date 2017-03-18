//
//  EditAuthorViewController.swift
//  FoodPin
//
//  Created by WuQiang on 2017/3/16.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class EditAuthorViewController: UIViewController {
    @IBOutlet weak var authorName: UITextField!
    var context: NSManagedObjectContext!
    var selectedAuthor: Authors!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorName.becomeFirstResponder()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
    /*
    @IBAction func saveAuthor(_ sender: UIBarButtonItem) {
        let name = authorName.text!.trimmingCharacters(in: .whitespaces)
        if name != "" {
            selectedAuthor = Authors(context: context)
            selectedAuthor.name = name
            do {
                try context.save()
                performSegue(withIdentifier: "backFromNew", sender: self)
            } catch {
                print("Error")
            }
        }
    }
    */
    // Listing 22-16: Checking for duplicates
    @IBAction func saveAuthor(_ sender: UIBarButtonItem) {
        let name = authorName.text!.trimmingCharacters(in: .whitespaces)
        if name != "" {
            let request: NSFetchRequest<Authors> = Authors.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", name)
            
            if let total = try? context.count(for: request) {
                if total == 0 {
                    selectedAuthor = Authors(context: context)
                    selectedAuthor.name = name
                    do {
                        try context.save()
                        performSegue(withIdentifier: "backFromNew", sender: self)
                    } catch {
                        print("Error")
                    }
                }
            }
        }
    }
}
