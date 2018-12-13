//
//  ViewController.swift
//  MemeMe
//
//  Created by فدوى العسكر on 06/03/1440 AH.
//  Copyright © 1440 فدوى العسكر. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var navigationBarr: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var upperToolbar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    let memeTextAttributes:[NSAttributedString.Key: Any] = [
        
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeColor : UIColor.black,        NSAttributedString.Key.foregroundColor : UIColor.white

    ]
    var firstTimeTop = true
     var firstTimeBottom = true
    var topFieldChosen = false
    //var bottomFieldChosen = false


    
    override func viewDidLoad() {
        super.viewDidLoad()
            topTextField.text="TOP"
         bottomTextField.text="BOTTOM"
        topTextField.defaultTextAttributes=memeTextAttributes
        bottomTextField.defaultTextAttributes=memeTextAttributes
        topTextField.delegate = self
        bottomTextField.delegate=self
        if(imagePickerView.image == nil){
        shareButton.isEnabled = false
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool){
    super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        topTextField.textAlignment =   .center
        bottomTextField.textAlignment =   .center
         subscribeToKeyboardNotifications()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
       self.tabBarController?.tabBar.isHidden = false
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField){
        if(textField.tag == 0){
            topFieldChosen = true
        }
        
        
        if(firstTimeTop && textField.text=="TOP"){
       textField.text=""
            firstTimeTop=false
        }
        else if (firstTimeBottom && textField.text=="BOTTOM"){
            textField.text=""
            firstTimeBottom=false
        }
        
        
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled=true
            
            
        }
        
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)

        
        
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification){
        if(!topFieldChosen){
            
        view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
        
        
    }
    @objc func keyboardWillHide(_ notification:Notification){
        if(!topFieldChosen){
        view.frame.origin.y = 0
        }
        else{
        topFieldChosen = false
        }

    }
    func getKeyboardHeight(_ notification:Notification)  ->CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        
    }
    
    func subscribeToKeyboardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func save(memedImage1:UIImage) {
        
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage1)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
 
        
        
    }
    
    @IBAction func shareImage(){
        let memedImage0 = generateMemedImage()
        let activityViewController = UIActivityViewController (activityItems: [memedImage0], applicationActivities:[])
      // activityViewController.delegate = self
        
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
                
                
                self.save(memedImage1:memedImage0)
               // self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
                let alert = UIAlertController(title: "Warning", message: "There is something went wrong :(", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                
                self.present(alert, animated: true)
            }
        };
        
    }
    
    func generateMemedImage() -> UIImage {
        
        
        self.upperToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
        self.navigationBarr.isHidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        self.upperToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
        self.navigationBarr.isHidden=false


        return memedImage
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image=nil
        shareButton.isEnabled = false


    }
    
    @IBAction func doneClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    
    }



