//
//  BooksViewController.swift
//  FoodPin
//
//  Created by WuQiang on 2017/3/15.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class BooksViewController: UITableViewController {
    var context: NSManagedObjectContext!
    var listOfBooks: [Books] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
 */
    /*
    // Listing 22-11: Filtering books by year
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        request.predicate = NSPredicate(format: "year = 2016")
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    */
    /*
    // Listing 22-12: Filtering books by author
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        request.predicate = NSPredicate(format: "author.name = 'Third'")
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    */
    
    /*
  //  Listing 22-13: Creating filters with placeholders
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let search = "SecondAuthor"
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        request.predicate = NSPredicate(format: "author.name = %@", search)
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
 */
    /*
   // Listing 22-14: Creating filters with multiple values
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let search = "SecondAuthor"
        let year = 98
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        request.predicate = NSPredicate(format: "author.name = %@ && year = %d", search, year)
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    */
    /*
    //Listing 22-15: Filtering values with predicate keywords
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let search = "Sec"
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        request.predicate = NSPredicate(format: "author.name BEGINSWITH[c] %@", search)
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    */
    /*
   // Listing 22-17: Sorting the books by title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    */
    /*
    // Listing 22-18: Sorting books by author and year
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        let sort1 = NSSortDescriptor(key: "author.name", ascending: true)
        let sort2 = NSSortDescriptor(key: "year", ascending: true)
        request.sortDescriptors = [sort1, sort2]
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
 */
    // Listing 22-19: Sorting books by title without differentiating between lower- and upper-case letters
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        do {
            listOfBooks = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBooks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell", for: indexPath) as! BooksCell
        
        let book = listOfBooks[indexPath.row]
        cell.bookTitle.text = book.title
        cell.bookCover.image = book.thumbnail as? UIImage
        cell.bookYear.text = "Year: \(book.year)"
        
        let author = book.author
        if author != nil {
            cell.bookAuthor.text = author!.name
        } else {
            cell.bookAuthor.text = "Not Defined"
        }
        return cell
    }
    
    // Listing 22-20: Deleting a book
    // 直接在屏幕上左划出现删除菜单
    @IBAction func editBooks(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
     // Listing 22-20: Deleting a book
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = listOfBooks[indexPath.row]
            context.delete(book)
            do {
                try context.save()
                listOfBooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Error")
            }
        }
    }
    
    
}
