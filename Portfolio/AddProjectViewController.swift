//
//  AddProjectViewController.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 14/02/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var projectTitleTextField: UITextField!
    @IBOutlet weak var projectDescriptionTextField: UITextField!
    let imagePickerController = UIImagePickerController()
    var usersImage: UIImage!
    var imageURL: NSURL?
    var projects = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        loadCoreData()
    }
    //
    
    
    func loadCoreData() {
        // 1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Project")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            projects = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    
    @IBAction func onAddPhotoTapped(sender: AnyObject) {
    }
    //

    @IBAction func onAddCoverPhotoTapped(sender: AnyObject) {
        presentCamera()
    }
    //
    
    func presentCamera()
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func onSaveButtonTapped(sender: AnyObject) {
        let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let newProject = NSEntityDescription.insertNewObjectForEntityForName("Project", inManagedObjectContext: context)
        newProject.setValue(projectTitleTextField.text, forKey: "projectTitle")
        newProject.setValue(projectDescriptionTextField.text, forKey: "projectWriteUp")
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
        performSegueWithIdentifier("unwindToRoot", sender: self)
    }
    //
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToRoot" {
            print("Segue performed successfully.")
        }
    }
    
} // The end
