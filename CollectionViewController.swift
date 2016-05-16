import UIKit
import CoreData
import AVFoundation
import CoreGraphics

var collectionViewWidth = CGFloat()

class CollectionViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var uiCollectionView: UICollectionView!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var shouldReloadCollectionView = false
    var blockOperation = NSBlockOperation()
    var _fetchedResultsController: NSFetchedResultsController? = nil
    var testArray = ["432 Park Avenue", "This is a long sentence to see how it fits in the collectionview", "This is shorter", "Sentence here", "Another sentence and another"]
    //    let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //    let context : NSManagedObjectContext = appDel.managedObjectContext
    var reuseIdentifier = "Cell"
        
    
    let gridFlowLayout = ProductsGridFlowLayout()
    let isGridFlowLayoutUsed = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        collectionViewWidth = CGRectGetWidth(uiCollectionView!.frame)
        print("collectionViewWidth: \(collectionViewWidth)")
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.uiCollectionView.collectionViewLayout.invalidateLayout()
            self.uiCollectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        }
        uiCollectionView.collectionViewLayout = gridFlowLayout
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CollectionViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    //
    

    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.uiCollectionView.collectionViewLayout.invalidateLayout()
                self.uiCollectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            }
            uiCollectionView.collectionViewLayout = gridFlowLayout
            print("landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.uiCollectionView.collectionViewLayout.invalidateLayout()
                self.uiCollectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            }
            uiCollectionView.collectionViewLayout = gridFlowLayout
            print("Portrait")
        }
        
    }
    
    
    //layout collectionview cell
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        let numberOfCell: CGFloat = 3.5   //you need to give a type as CGFloat
//        let cellWidth = UIScreen.mainScreen().bounds.size.width / numberOfCell
//        let cellHeight = UIScreen.mainScreen().bounds.size.width / numberOfCell + 45
//        return CGSizeMake(cellWidth, cellHeight)
//    }//


    override func viewDidLayoutSubviews() {
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
    }
    
    
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

    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //        return self.fetchedResultsController.sections?.count ?? 0
        return 1
    }
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
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = uiCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.collectionImageView.image = UIImage(named: "placeholder")
        cell.collectionLabel.text = testArray[indexPath.item]
        cell.contentView.layer.borderWidth = 0.5
        cell.layer.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0).CGColor
        cell.contentView.layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).CGColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).CGPath

        return cell
    }
    
} // THE END


