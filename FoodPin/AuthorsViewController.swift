//
//  AuthorsViewController.swift
//  FoodPin
//
//  Created by WuQiang on 2017/3/16.
//  Copyright © 2017年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class AuthorsViewController: UITableViewController {
    var context: NSManagedObjectContext!
    var listOfAuthors: [Authors] = []
    var selectedAuthor: Authors!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request: NSFetchRequest<Authors> = Authors.fetchRequest()
        do {
            listOfAuthors = try context.fetch(request)
        } catch {
            print("Error")
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAuthors.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "authorsCell", for: indexPath)
        let author = listOfAuthors[indexPath.row]
        let name = author.name
        
        var total = 0
        if let totalBooks = author.books {
            total = totalBooks.count
        }
        cell.textLabel?.text = "\(name!) (\(total))"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAuthor = listOfAuthors[indexPath.row]
        performSegue(withIdentifier: "backFromList", sender: self)
    }
}
