import UIKit
import CoreData

class BooksViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var context: NSManagedObjectContext!
    var fetchedController: NSFetchedResultsController<Books>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
        
        let request: NSFetchRequest<Books> = Books.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        fetchedController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedController.delegate = self
        do {
            try fetchedController.performFetch()
        } catch {
            print("Error")
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell", for: indexPath) as! BooksCell
        updateCell(cell: cell, path: indexPath)
        return cell
    }
    func updateCell(cell: BooksCell, path: IndexPath) {
        let book = fetchedController.object(at: path)
        cell.bookTitle.text = book.title
        cell.bookCover.image = book.thumbnail as? UIImage
        let year = book.year
        cell.bookYear.text = "Year: \(year)"
        let authorName = book.author?.name
        if authorName != nil {
            cell.bookAuthor.text = authorName
        } else {
            cell.bookAuthor.text = "Not Defined"
        }
    }
}
