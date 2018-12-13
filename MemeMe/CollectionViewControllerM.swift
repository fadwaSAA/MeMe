//
//  CollectionViewControllerM.swift
//  MemeMe
//
//  Created by فدوى العسكر on 19/03/1440 AH.
//  Copyright © 1440 فدوى العسكر. All rights reserved.
//

import UIKit
class CollectionViewControllerM: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
     @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        //flowLayout = UICollectionViewFlowLayout()
        
        /*
        let collectionSpace:CGFloat = 0
        let collectionDimension = (collectionView.frame.size.width - (2 * collectionSpace)) / 1
        
        flowLayout.minimumInteritemSpacing = collectionSpace
        flowLayout.minimumLineSpacing = collectionSpace
        flowLayout.itemSize = CGSize(width: collectionDimension, height: collectionDimension)
        */
        print("llllll")
        
        
        //Mtable.reloadData()
        //Mtable.register(UITableView.self, forCellReuseIdentifier: "CellReuseIdentifier")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Mtable.delegate = self
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView.delegate=self
        collectionView.reloadData()
        
        
        
        //print("sizeeee\(memes.count)")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView1")

        return self.memes.count;

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView2")

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemedCollectionViewCell", for: indexPath) as! MemeCollectionCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memedImage?.image =  meme.memedImage
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        print("collectionView3")

         
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewControllerM
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 0, bottom:5, right: 0)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("flow1")

        //let framewidth = view.frame.width - 10
        let collectionHeight = (collectionView.frame.height) / 4
        let dimension = (collectionView.frame.width - 10) / 3
        return CGSize(width: dimension, height: collectionHeight)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        print("flow2")

        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("flow3")

        return 5
    }
    
    
    @IBAction func addPic(_ sender: Any) {
        let addMeme = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        //Populate view controller with data from the selected item
        
        // Present the view controller using navigation
        navigationController!.pushViewController(addMeme, animated: true)
    }
}
/*
extension CollectionViewControllerM: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let framewidth = view.frame.width - 10
        let dimension = (view.frame.width - 8) / 3
        return CGSize(width: dimension, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
 
    
}*/
