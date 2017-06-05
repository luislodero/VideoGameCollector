//
//  ViewController.swift
//  VideoGameCollector
//
//  Created by Luis Lopez on 6/2/17.
//  Copyright © 2017 Luis Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games : [VideoGame] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        games = try context.fetch(VideoGame.fetchRequest())
        tableView.reloadData()
        } catch{
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games [indexPath.row]
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: (game.image as! NSData) as Data)
        return cell
        
    }



}
