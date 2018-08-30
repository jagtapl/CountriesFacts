//
//  ViewController.swift
//  CountriesFacts
//
//  Created by LALIT JAGTAP on 7/30/18.
//  Copyright © 2018 LALIT JAGTAP. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        // read string from JSON file
        if let pathToFile = Bundle.main.path(forResource: "countriesfacts", ofType: "json") {
            if let stringContentsOfFile = try? String(contentsOfFile: pathToFile) {
                let json = JSON(parseJSON: stringContentsOfFile)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    self.parse(json: json)
                    return
                }
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }

    func parse(json: JSON) {
        print("parse json from a string read from a file \(json)")
        for result in json["countries"].arrayValue {
            let name = result["name"].stringValue
            let capital = result["capital"].stringValue
            let population = result["population"].stringValue
            let obj = ["name": name, "capital": capital, "population": population]
            countries.append(obj)
        }
        print("parsed json results in array of contries \(countries)")
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "JSON Loading error", message: "Error occured while reading JSON from a file", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        let countryObj = countries[indexPath.row]
        cell.textLabel?.text = countryObj["name"]
        cell.detailTextLabel?.text = countryObj["capital"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

