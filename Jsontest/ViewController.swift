//
//  ViewController.swift
//  Jsontest
//
//  Created by Quy Nguyen on 10/11/15.
//  Copyright © 2015 Quy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UITableViewController {
    
    struct Objects{
    var tieude = String()
    var thanhphan = [String]()
    }
    
    var ObjectsArray = [Objects]()
    
    
    var Numofrow = 0
    var NamesArray = [String]()
    var AgeArray = [String]()
    var listperson = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         parseJSON()
    }
    
    func parseJSON(){
        let path : String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: jsonData, options:NSJSONReadingOptions.MutableContainers, error: nil)
        
        var name = readableJSON["People"]["Person1"]["Age"]
        Numofrow = readableJSON["People"].count
        for i in 1...Numofrow{
        var person = "Person"
            person += "\(i)"
        var name = readableJSON["People"][person]["Name"].string as String!
        var age = readableJSON["People"][person]["Age"].string as String!
            NamesArray.append(name)
            AgeArray.append(age)
            listperson.append(person)
            ObjectsArray.append(Objects(tieude: person,thanhphan: [name,age]))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//ObjectsArray[section].thanhphan.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        if ObjectsArray.count != 0{

        cell.textLabel?.text = ObjectsArray[indexPath.section].thanhphan[indexPath.row]
            print("section:\(indexPath.section) - row:\(indexPath.row) ")
        }
        return cell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ObjectsArray.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ObjectsArray[section].tieude
    }
}

