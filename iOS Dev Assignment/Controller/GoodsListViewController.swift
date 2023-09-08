//
//  GoodsListViewController.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 20.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import UIKit

let reuseIdentifier = "GoodCardCell"

class GoodsListCollectionViewController: UICollectionViewController {

    var goodsList = [GoodItem]()
    let basket = Basket(currency: Currency(name: "GBP", longName: "Pound Sterling", factorToGBP: 1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goodCardCellNib = UINib(nibName: "GoodCardCell", bundle: nil)
        self.collectionView!.registerNib(goodCardCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupData()
    }
    
    func setupData() {
        let milk = GoodItem(name: "Milk", priceInGBP: 0.95, containerName: "carton", image: UIImage(named: "milk"))
        let cola = GoodItem(name: "Cola", priceInGBP: 0.50, containerName: "can", image: UIImage(named: "cola"))
        let beer = GoodItem(name: "Beer", priceInGBP: 4.99, containerName: "pack", image: UIImage(named: "beer"))
        let wine = GoodItem(name: "Wine", priceInGBP: 10.90, containerName: "bottle", image: UIImage(named: "wine"))
        goodsList += [milk, cola, beer, wine]
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GoodCardCell
    
        let g = goodsList[indexPath.row]
        cell.goodNameLabel?.text = g.name
        cell.goodPriceLabel?.text = "£\(g.priceInGBP) per \(g.containerName)"
        cell.setImage(g.image, animated: true, delay: Double(indexPath.row) / 6)

        cell.plusButton.addTarget(self, action: Selector("plusButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.minusButton.addTarget(self, action: Selector("minusButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func plusButtonPressed(sender: UIButton!) {
        if let cell = sender.superview?.superview as? GoodCardCell {
            if let index = collectionView?.indexPathForCell(cell) {
                let selectedGoodItem = goodsList[index.row]
                basket.addGoodItem(selectedGoodItem)
                cell.amountLabel.text = "Amount: \(basket.getAmountOfGoodItems(selectedGoodItem))"
            }
        }
    }
    
    func minusButtonPressed(sender: UIButton!) {
        if let cell = sender.superview?.superview as? GoodCardCell {
            if let index = collectionView?.indexPathForCell(cell) {
                let selectedGoodItem = goodsList[index.row]
                basket.removeGoodItem(selectedGoodItem)
                cell.amountLabel.text = "Amount: \(basket.getAmountOfGoodItems(selectedGoodItem))"
            }
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toResult") {
            let rvc = segue.destinationViewController as! ResultViewController
            rvc.basket = basket
        }
    }
    
}
