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
    var projects = [NSManagedObject]()
    
    var testArray = ["432 Park Avenue", "Sotheby's", "The Blue Curve", "Sentence here", "Another sentence and another", "Across 110th Street", "Ellsworth", "This is shorter", "Sentence here", "Another sentence and another", "432 Park Avenue", "Mark Rothko", "This is shorter", "Sentence here", "Another sentence and another", "432 Park Avenue", "This is a long sentence to see how it fits in the collectionview", "This is shorter", "Sentence here", "Another sentence and another", "432 Park Avenue", "This is a long sentence to see how it fits in the collectionview", "This is shorter", "Sentence here", "Another sentence and another"]
    //    let appDel : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //    let context : NSManagedObjectContext = appDel.managedObjectContext
    var reuseIdentifier = "Cell"
    
    
    let gridFlowLayout = ProductsGridFlowLayout()
    let isGridFlowLayoutUsed = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        addBlurEffect()
    }
    //
    
    
    override func viewWillAppear(animated: Bool) {
        loadCoreData()
    }
    //
    
    
    func loadCoreData() {
        //1
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
        
        self.uiCollectionView.reloadData()
        print("Collectionview data reloaded")
        
    }
    
    
    func addBlurEffect() {
        // Add blur view
        let bounds = self.navigationController?.navigationBar.bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            drawCollectionView()
            self.uiCollectionView.reloadData()
            print("Reloaded")
            print("landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            drawCollectionView()
            self.uiCollectionView.reloadData()
            print("Reloaded")
            print("Portrait")
        }
        
    }
    
    func drawCollectionView() {
        UIView.animateWithDuration(0.2) { () -> Void in
            let collectionViewLayout = self.uiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            collectionViewLayout?.sectionInset = UIEdgeInsetsMake(20, 0, 100, 0)
            self.uiCollectionView.collectionViewLayout.invalidateLayout()
            self.uiCollectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        }
        uiCollectionView.collectionViewLayout = gridFlowLayout
    }
    
    
    override func viewDidLayoutSubviews() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CollectionViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.drawCollectionView()
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    //
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = uiCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        let cellProject = projects[indexPath.row]
        
        cell.collectionImageView.image = UIImage(named: "placeholder")
        cell.collectionLabel.text = cellProject.valueForKey("projectTitle") as? String
        cell.contentView.layer.borderWidth = 0.5
        cell.layer.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0).CGColor
        cell.contentView.layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).CGColor
        
        return cell
    }
    
} // THE END


