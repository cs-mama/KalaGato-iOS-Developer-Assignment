//
//  SelectCurrencyTVC.swift
//  
//
//  Created by Arthur Myronenko on 20.05.15.
//
//

import UIKit

class SelectCurrencyTVC: UITableViewController {

    var basket: Basket!
    var currencies = [Currency]()
    
    override func viewDidAppear(animated: Bool) {
        self.fetchCurrencies()
    }

    @IBAction func fetchCurrencies() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        refreshControl?.beginRefreshing()
        
        JSONRatesAPI.requestCurrenciesList { (currList) in
            JSONRatesAPI.requestAllRates("GBP") { (currenciesDictionary) -> () in
                self.currencies.removeAll(keepCapacity: false)
                for curr in currenciesDictionary {
                    if let longname = currList[curr.0] {
                        self.currencies.append(Currency(name: curr.0, longName: longname, factorToGBP: curr.1))
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectCurrencyCell", forIndexPath: indexPath) 

        let curr = currencies[indexPath.row]
        cell.textLabel!.text = curr.name
        cell.detailTextLabel!.text = curr.longName

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCurrency = currencies[indexPath.row]
        basket.currentCurrency = selectedCurrency
        self.navigationController?.popViewControllerAnimated(true)
    }

}
