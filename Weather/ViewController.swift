//
//  ViewController.swift
//  Weather
//
//  Created by Vasia Leleka on 21.05.2019.
//  Copyright © 2019 Vasia Leleka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
           searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
  extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var locationMain : String?
        var temp : Double?
        print(searchBar.text!)
        let urlString = "https://api.apixu.com/v1/current.json?key=6d5e4821328f498aade150303192105&q="+searchBar.text!
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let location  = json["location"] {
                    locationMain = location["name"] as? String
                }
                if let current = json["current"]{
                    temp = current["temp_c"] as? Double
                    print(temp)
                }
            } catch let jsonError{
                print(jsonError)
            }
        }
            task.resume()
        
    }

}
