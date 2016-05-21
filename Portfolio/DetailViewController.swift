//
//  DetailViewController.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 14/02/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    var selectedIndexPath: NSIndexPath! = nil
    var project : Project! = nil
    var detailItem: AnyObject? {
        didSet {
        }
    }

//    lazy var context: NSManagedObjectContext = {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        return appDelegate.managedObjectContext
//    }()
//    var fetchedResultsController: NSFetchedResultsController!
    
    
    override func viewDidLoad() {
//        configureView()
        self.navigationController!.navigationBar.topItem!.title = ""
    }
    //
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let titleLabel = self.detailItem {
            if let label = self.titleTextLabel {
                label.text = titleLabel.valueForKey("projectTitle")!.description
            }
        }
        if let desctionLabel = self.detailItem {
            if let label = self.descriptionTextLabel {
                label.text = desctionLabel.valueForKey("projectWriteUp")!.description
            }
        }
    }
    //
    
    @IBAction func deleteCurrentProject(sender: AnyObject) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let moc = appDelegate.managedObjectContext
//        let entity = fetchedResultsController.objectAtIndexPath(selectedIndexPath) as! Project
//
//        moc.deleteObject(entity)
//        do {
//            try moc.save()
//        } catch let error as NSError {
//            print("Error saving context after delete: \(error.localizedDescription)")
//        }
//        performSegueWithIdentifier("unwindToRoot", sender: self)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "unwindToRoot" {
//            print("Segue performed successfully.")
//        }
    }
    
} // The End