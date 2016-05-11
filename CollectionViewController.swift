import UIKit
import CoreData
import AVFoundation

protocol MortarStyleLayoutDelegate {
    // 1. Method to ask the delegate for the height of the image
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth:CGFloat) -> CGFloat
    // 2. Method to ask the delegate for the height of the annotation text
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
    
}

class CollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var uiCollectionView: UICollectionView!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var shouldReloadCollectionView = false
    var blockOperation = NSBlockOperation()
    var _fetchedResultsController: NSFetchedResultsController? = nil
    var testArray = ["1", "2", "3", "4", "1", "2", "3","1", "2", "3", "4", "1", "2", "3","1", "2", "3", "4", "1", "2", "3","1", "2", "3", "4", "1", "2", "3","1", "2", "3", "4", "1", "2", "3","1", "2", "3", "4", "1", "2", "3"]
    //    let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //    let context : NSManagedObjectContext = appDel.managedObjectContext
    var reuseIdentifier = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        //        // Set the PinterestLayout delegate
        //        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
        //            layout.delegate = self
        //        }
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        uiCollectionView!.backgroundColor = UIColor.clearColor()
        uiCollectionView?.contentSize.height = screenHeight/3 - 40
        print(screenHeight/3 - 40)
        uiCollectionView?.contentSize.width = screenWidth/3 - 40
        print(screenWidth/3 - 40)
        uiCollectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    }
    //
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    
    
    //    // MARK: - Fetched results controller
    //    var fetchedResultsController: NSFetchedResultsController {
    //        if _fetchedResultsController != nil {
    //            return _fetchedResultsController!
    //        }
    //
    //        let fetchRequest = NSFetchRequest()
    //        let entity = NSEntityDescription.entityForName("Project", inManagedObjectContext: self.managedObjectContext!)
    //        fetchRequest.entity = entity
    //        print(entity)
    //
    //        // Set the batch size to a suitable number.
    //        //        fetchRequest.fetchBatchSize = 30
    //
    //        // Edit the sort key as appropriate.
    //        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: true)
    //
    //        fetchRequest.sortDescriptors = [sortDescriptor]
    //
    //        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
    //        aFetchedResultsController.delegate = self
    //        _fetchedResultsController = aFetchedResultsController
    //
    //        do {
    //            try _fetchedResultsController!.performFetch()
    //        } catch {
    //            print("An error occured")
    //            abort()
    //        }
    //        return _fetchedResultsController!
    //    }
    //    //
    //
    //
    //
    //    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    //        let collectionView = self.collectionView
    //        switch type {
    //        case NSFetchedResultsChangeType.Insert:
    //            self.blockOperation.addExecutionBlock({
    //                collectionView!.insertSections( NSIndexSet(index: sectionIndex) )
    //            })
    //        case NSFetchedResultsChangeType.Delete:
    //            self.blockOperation.addExecutionBlock({
    //                collectionView!.deleteSections( NSIndexSet(index: sectionIndex) )
    //            })
    //        case NSFetchedResultsChangeType.Update:
    //            self.blockOperation.addExecutionBlock({
    //                collectionView!.reloadSections( NSIndexSet(index: sectionIndex ) )
    //            })
    //        default:()
    //        }
    //    }
    //    //
    //
    //
    //    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    //        let collectionView = self.collectionView
    //        switch type {
    //        case NSFetchedResultsChangeType.Insert:
    //            if collectionView!.numberOfSections() > 0 {
    //
    //                if collectionView!.numberOfItemsInSection( newIndexPath!.section ) == 0 {
    //                    self.shouldReloadCollectionView = true
    //                } else {
    //                    self.blockOperation.addExecutionBlock({
    //                        collectionView!.insertItemsAtIndexPaths( [newIndexPath!] )
    //                    })
    //                }
    //
    //            } else {
    //                self.shouldReloadCollectionView = true
    //            }
    //
    //        case NSFetchedResultsChangeType.Delete:
    //            if collectionView!.numberOfItemsInSection( indexPath!.section ) == 1 {
    //                self.shouldReloadCollectionView = true
    //            } else {
    //                self.blockOperation.addExecutionBlock({
    //                    collectionView!.deleteItemsAtIndexPaths( [indexPath!] )
    //                })
    //            }
    //
    //        case NSFetchedResultsChangeType.Update:
    //            self.blockOperation.addExecutionBlock({
    //                collectionView!.reloadItemsAtIndexPaths( [indexPath!] )
    //            })
    //
    //        case NSFetchedResultsChangeType.Move:
    //            self.blockOperation.addExecutionBlock({
    //                collectionView!.moveItemAtIndexPath( indexPath!, toIndexPath: newIndexPath! )
    //            })
    //        default:()
    //        }
    //    }
    //    //
    //
    //
    //    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    //        // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
    //        if self.shouldReloadCollectionView {
    //            self.collectionView!.reloadData()
    //        } else {
    //            self.collectionView!.performBatchUpdates({
    //                self.blockOperation.start()
    //                }, completion: nil )
    //        }
    //    }
    //    //
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //        return self.fetchedResultsController.sections?.count ?? 0
        return 1
    }
    //
    
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        //        let cellWidth = CGSize()
        //        let cellHeight = CGSize()
        return CGSizeMake((UIScreen.mainScreen().bounds.width-15)/4,120); //use height whatever //
        let cellHeight = screenHeight/2 - 40
        print(cellHeight)
        let cellWidth = screenWidth/2 - 40
        print(cellWidth)
        return CGSizeMake(cellWidth, cellHeight)
    }
    
    
    // func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    // let leftRightInset = self.view.frame.size.width / 14.0
    // return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    // }
    //
    
    
    //    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    //        switch type {
    //        case .Insert:
    //            self.uiCollectionView.insertSections(NSIndexSet(index: sectionIndex))
    //        case .Delete:
    //            self.uiCollectionView.deleteSections(NSIndexSet(index: sectionIndex))
    //        default:
    //            return
    //        }
    //    }
    //    //
    
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Project
        let cell = uiCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.collectionImageView.image = UIImage(named: "placeholder")
        cell.collectionLabel.text = testArray[indexPath.item]
        //        cell.collectionLabel.text = testArray[indexPath.item]
        //        cell.collectionLabel.text = object.valueForKey("projectTitle")!.description
        print(cell)
        return cell
    }
    
    
    //    // 1. Returns the photo height
    //    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth width:CGFloat) -> CGFloat {
    //        let photo = UIImage(named: "placeholder")
    //        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    //        let rect  = AVMakeRectWithAspectRatioInsideRect(photo!.size, boundingRect)
    //        return rect.size.height
    //    }
    
    //    // 2. Returns the annotation size based on the text
    //    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
    //        let annotationPadding = CGFloat(4)
    //        let annotationHeaderHeight = CGFloat(17)
    //        let commentHeight = CGFloat(50)
    //
    //        //        let photo = testArray[indexPath.item]
    //        //        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
    //        //        let commentHeight = photo.heightForComment(font, width: width)
    //        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
    //        return height
    //}
    
} // THE END



// Add anywhere in your app
extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}