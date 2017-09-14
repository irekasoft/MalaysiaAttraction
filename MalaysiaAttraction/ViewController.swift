//
//  ViewController.swift
//  MalaysiaAttraction
//
//  Created by Hijazi on 11/9/17.
//  Copyright © 2017 iReka Soft. All rights reserved.
//

import UIKit
import CSV
import CSVImporter

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var attractions : [ [String:String] ]?
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let stream = InputStream(fileAtPath: Bundle.main.path(forResource: "attraction", ofType: "csv")!)!
    
    var csv = try! CSV(stream: stream)

    while let row = csv.next() {
      
    }
    
    ///
    let path = Bundle.main.path(forResource: "attraction", ofType: "csv")!
    let importer = CSVImporter<[String: String]>(path: path)
    importer.startImportingRecords(structure: { (headerValues) -> Void in
      
      print(headerValues) // => ["firstName", "lastName"]
      
    }) { $0 }.onFinish { importedRecords in
      
      self.attractions = importedRecords
      self.tableView.reloadData()
      
      for record in importedRecords {
        print(record) // => e.g. ["firstName": "Harry", "lastName": "Potter"]
        print(record["no"]) // prints "Harry" on first, "Hermione" on second run
        print(record["state"]) // prints "Potter" on first, "Granger" on second run
      }
      
    }
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource, UITableViewDelegate
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if let atts = attractions {
      
      return atts.count
      
    }else {
      
      return 0
    }
    
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
    let attraction = self.attractions?[indexPath.row]
    
    cell?.textLabel?.text = attraction?["name"]
    cell?.detailTextLabel?.text = attraction?["state"]
    
    return cell!
    
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "showDetail", sender: nil)
    
  }
  

}

