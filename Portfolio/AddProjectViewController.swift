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
    }
    //
    
    
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Project", inManagedObjectContext: moc)
        let projectToAdd = Project(entity:entity!, insertIntoManagedObjectContext: moc)
        
        projectToAdd.setValue(projectTitleTextField.text, forKey: "projectTitle")
        projectToAdd.setValue(projectDescriptionTextField.text, forKey: "projectWriteUp")
        print(NSDate())
        projectToAdd.setValue(NSDate(), forKey: "timeStamp")
        
        do {
            try moc.save()
        } catch let error as NSError {
            print("Error saving movie \(error.localizedDescription)")
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
