//
//  DebtsViewController.swift
//  Expenses
//
//  Created by Oliver Wilkie on 8/28/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import UIKit
import CoreData

class SettlementsViewController: UITableViewController {
    
    var event:Event?
    var settlementRecommendations:[SettlementRecommendation]?
    let settlementService = SettlementService.sharedInstance
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.parent?.navigationItem.setRightBarButton(shareButton, animated: animated)
        
        // TODO - Is this the right way to do this?
        let parentTabController = self.tabBarController! as! EventViewController
        event = parentTabController.event
        
        self.settlementRecommendations = settlementService.getRecommendations(for: event!)
        tableView.reloadData()
    }
    
    func displayShareSheet(_ shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    func makePayment(_ settlementRecommendation:SettlementRecommendation) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Payback", in: managedContext)
        let newPayback = NSManagedObject(entity: entity!, insertInto: managedContext) as! Payback
        newPayback.sender = settlementRecommendation.from
        newPayback.receiver = settlementRecommendation.to
        newPayback.amount_integer_part = settlementRecommendation.amount.integerPart() as NSNumber?
        newPayback.amount_decimal_part = settlementRecommendation.amount.decimalPart() as NSNumber?
        newPayback.paid_back_at = Date()
        self.event?.addPaybacksObject(newPayback)
        do {
            try managedContext.save()
        } catch _ {}
        self.tableView.reloadData()
    }
    
    func displayActionSheet(_ settlementRecommendation:SettlementRecommendation) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let markPaidAction = UIAlertAction(title: "Mark Paid", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.makePayment(settlementRecommendation)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(markPaidAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settlementRecommendations!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settlementRecommendationCell", for: indexPath)

        let recommendation = settlementRecommendations![(indexPath as NSIndexPath).row]
        let from = recommendation.from.name!
        let to = recommendation.to.name!
        let amount = recommendation.amount
        cell.textLabel?.text = "\(from) to \(to) for \(AmountHelper.prettyAmount(amount))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settlementRecommendation = self.settlementRecommendations![(indexPath as NSIndexPath).row]
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
    
    @IBAction func shareButtonClicked(_ sender: AnyObject) {
        displayShareSheet("Hello")
    }

}
