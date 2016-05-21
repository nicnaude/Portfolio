import UIKit
import CoreData
import AVFoundation
import CoreGraphics

var collectionViewWidth = CGFloat()

class CollectionViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var uiCollectionView: UICollectionView!
    @IBAction func unwindToRoot(segue: UIStoryboardSegue) {}
    
    var moc: NSManagedObjectContext? = nil
    var shouldReloadCollectionView = false
    var blockOperation = NSBlockOperation()
    var projects = [NSManagedObject]()
    var reuseIdentifier = "Cell"
    var selectedIndexPath: NSIndexPath! = nil
    
    let gridFlowLayout = ProductsGridFlowLayout()
    let isGridFlowLayoutUsed = true
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    var fetchedResultsController: NSFetchedResultsController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        addBlurEffect()
        loadCoreData()
    }
    //
    
    
    override func viewWillAppear(animated: Bool) {
        loadCoreData()
    }
    //
    
    
    func loadCoreData() {
        let fetchRequest = NSFetchRequest(entityName: "Project")
        let fetchSort = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [fetchSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
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
        guard let sectionCount = fetchedResultsController.sections?.count else {
            return 0
        }
        return sectionCount
    }
    //
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionData = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    //
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let projectForCell = fetchedResultsController.objectAtIndexPath(indexPath) as! Project
    
        let cell = uiCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        selectedIndexPath = indexPath
        
        cell.collectionImageView.image = UIImage(named: "placeholder")
        cell.collectionLabel.text = projectForCell.valueForKey("projectTitle") as? String
        cell.contentView.layer.borderWidth = 0.5
        cell.layer.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0).CGColor
        cell.contentView.layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).CGColor
        
        return cell
    }
    //
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProject" {
            let destination = segue.destinationViewController as! DetailViewController
            destination.selectedIndexPath = selectedIndexPath
            destination.coverImage.image = UIImage(named: "432")
        }
    }
    //
    
} // THE END


