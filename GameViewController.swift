//
//  GameViewController.swift
//  VideoGameCollector
//
//  Created by Luis Lopez on 6/2/17.
//  Copyright © 2017 Luis Lopez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var gameImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var game : VideoGame? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        if game != nil {gameImageView.image = UIImage(data: (game!.image as! NSData) as Data)
            titleTextField.text = game!.title
            
            addupdatebutton.setTitle("Update", for: .normal)
        }else{
            deletebutton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func photosTabbed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)

        
    }
    @IBAction func addTapped(_ sender: Any) {
        if game != nil {
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!) as! NSData

        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            
            let game = VideoGame(context: context)
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(gameImageView.image!) as! NSData
        }
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deletetapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
    }

    
    

