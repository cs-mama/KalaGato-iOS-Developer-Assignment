//
//  ResultViewController.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 20.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {

    var basket: Basket!

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        totalPriceLabel.text = "Total price of your basket: \(basket.totalPrice) \(basket.currentCurrency.name)"
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.amount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GoodItemInfo")!
        
        let (goodItem, amount) = Array(basket.goodsList)[indexPath.row]
        
        cell.textLabel!.text = "\(goodItem.name) x \(amount)"
        let goodItemsPrice = basket.currentCurrency.factorToGBP * Double(amount) * goodItem.priceInGBP
        let roundedPrice = Double(round(100 * goodItemsPrice) / 100)
        cell.detailTextLabel!.text = "\(roundedPrice) \(basket.currentCurrency.name)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCurrencySelect" {
            let scTVC = segue.destinationViewController as! SelectCurrencyTVC
            scTVC.basket = basket
        }
    }

}
