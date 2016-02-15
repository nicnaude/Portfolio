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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillDisappear(animated: Bool){
    //}
    
    @IBAction func onAddPhotoTapped(sender: AnyObject) {
    }

    @IBAction func onAddCoverPhotoTapped(sender: AnyObject) {
        presentCamera()
    }
    
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
