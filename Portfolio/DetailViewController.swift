//
//  DetailViewController.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 14/02/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    var project : Project! = nil
    
    var detailItem: AnyObject? {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        configureView()
    }
    
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
//    func configureCell (){
//        self.titleTextLabel.text = self.project?.projectTitle
//        self.descriptionTextLabel.text = self.project?.projectWriteUp
//    }
    
}