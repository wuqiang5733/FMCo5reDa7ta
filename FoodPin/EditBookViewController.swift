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
    @IBOutlet weak var authorName: UILabel!
    var context: NSManagedObjectContext!
    var selectedAuthor: Authors!
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitle.becomeFirstResponder()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
 */
    // Listing 22-9: Counting the authors available
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitle.becomeFirstResponder()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
        
        let request: NSFetchRequest<Authors> = Authors.fetchRequest()
        if let total = try? context.count(for: request) {
            print(total)
        }
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
            newBook.author = selectedAuthor
            
            do {
                try context.save()
            } catch {
                print("Error")
            }
           _ = navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func backAuthor(_ segue: UIStoryboardSegue) {
        if segue.identifier == "backFromList" {
            let controller = segue.source as! AuthorsViewController
            selectedAuthor = controller.selectedAuthor
            authorName.text = selectedAuthor.name
        } else if segue.identifier == "backFromNew" {
            let controller = segue.source as! EditAuthorViewController
            selectedAuthor = controller.selectedAuthor
            authorName.text = selectedAuthor.name
        }
    }
}
