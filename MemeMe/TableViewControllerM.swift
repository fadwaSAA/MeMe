//
//  TableViewController.swift
//  MemeMe
//
//  Created by فدوى العسكر on 19/03/1440 AH.
//  Copyright © 1440 فدوى العسكر. All rights reserved.
//

import UIKit
class TableViewControllerM: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var Mtable: UITableView!
 
    @IBOutlet weak var addButton: UIBarButtonItem!
    var memes: [Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // Mtable.delegate = self
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
         Mtable.reloadData()
        print("sizeeee\(memes.count)")

    }
 
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("i'm inside2\(memes.count)")

         return memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier") as! MemeTableCell
        
  print("i'm inside3")
        
        let meme = self.memes[(indexPath as NSIndexPath).row]

        
        cell.txtLabel!.text = meme.topText+"..."+meme.bottomText
        cell.imageview?.image = meme.memedImage
 
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewControllerM
        print("i'm inside4")

        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
        
    }
    
    
    
    
}
