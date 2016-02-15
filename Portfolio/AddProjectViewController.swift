//
//  AddProjectViewController.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 14/02/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit
import CoreData

class AddProjectViewController: UIViewController {
    
    @IBOutlet weak var projectTitleTextField: UITextField!
    
    @IBOutlet weak var projectDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillDisappear(animated: Bool){
    //}
    
    @IBAction func onTakePhotoTapped(sender: AnyObject) {
    }
    
    @IBAction func onChoosePhotoTapped(sender: AnyObject) {
    }
    
    @IBAction func onSaveButtonTapped(sender: AnyObject) {
        let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let newProject = NSEntityDescription.insertNewObjectForEntityForName("Project", inManagedObjectContext: context)
        newProject.setValue(projectTitleTextField.text, forKey: "projectTitle")
        newProject.setValue(projectDescriptionTextField.text, forKey: "projectWriteup")
        
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
    
}
