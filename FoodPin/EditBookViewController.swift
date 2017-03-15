//
//  EditBookViewController.swift
//  FoodPin
//
//  Created by WuQiang on 2017/3/15.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class EditBookViewController: UIViewController {
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookYear: UITextField!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitle.becomeFirstResponder()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        let year = Int32(bookYear.text!)
        let title = bookTitle.text!.trimmingCharacters(in: .whitespaces)
        if title != "" && year != nil {
            let newBook = Books(context: context)
            newBook.title = title
            newBook.year = year!
            newBook.cover = UIImage(named: "nocover")
            newBook.thumbnail = UIImage(named: "nothumbnail")
            newBook.author = nil
            
            do {
                try context.save()
            } catch {
                print("Error")
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
