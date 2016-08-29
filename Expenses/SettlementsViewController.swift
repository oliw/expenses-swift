//
//  DebtsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/28/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit

class SettlementsViewController: UITableViewController {
    
    var event:Event?
    var settlementRecommendations:[SettlementRecommendation]?
    
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.parentViewController?.navigationItem.setRightBarButtonItem(shareButton, animated: animated)
        
        // TODO - Is this the right way to do this?
        let parentTabController = self.tabBarController! as! EventViewController
        event = parentTabController.event
        
        let settlementService = SettlementService.sharedInstance
        self.settlementRecommendations = settlementService.getRecommendations(event!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
    func makePayment(settlementRecommendation:SettlementRecommendation) {
        
    }
    
    func displayActionSheet(settlementRecommendation:SettlementRecommendation) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let markPaidAction = UIAlertAction(title: "Mark Paid", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.makePayment(settlementRecommendation)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(markPaidAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settlementRecommendations!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settlementRecommendationCell", forIndexPath: indexPath)

        let recommendation = settlementRecommendations![indexPath.row]
        let from = recommendation.from.name!
        let to = recommendation.to.name!
        let amount = recommendation.amount
        cell.textLabel?.text = "\(from) to \(to) for \(AmountHelper.prettyAmount(amount))"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let settlementRecommendation = self.settlementRecommendations![indexPath.row]
        displayActionSheet(settlementRecommendation)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func shareButtonClicked(sender: AnyObject) {
        displayShareSheet("Hello")
    }

}
