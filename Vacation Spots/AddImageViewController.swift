//
//  AddImageViewController.swift
//  Vacation Spots
//
//  Created by Hayden Goldman on 3/20/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

protocol AddNewImageDelegate {
    func addImageDidSave(imageTitle :String, image :UIImage)
}

class AddImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleTextField: UITextField!
    var imagePicker :UIImagePickerController!
    var selectedImage :UIImage!
    var delegate :AddNewImageDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imageTitleTextField.delegate = self

    }
    
    //apply filter 
    @IBAction func monochromeButtonPressed() {
        
        DispatchQueue.global().async {
            
            let originalImage = CIImage(image: self.selectedImage)
            guard let monochromeFilter = CIFilter(name: "CIColorMonochrome") else {
                fatalError("CIColorMonochrome not available!")
            }
            monochromeFilter.setValue(originalImage, forKey: kCIInputImageKey)
            monochromeFilter.setValue(1.0, forKey: kCIInputIntensityKey)
            let monochromeImage = UIImage(ciImage: monochromeFilter.outputImage!)
            
            DispatchQueue.main.async {
                self.imageView.image = monochromeImage
            }
        }
    }
    
    @IBAction func sepiaButtonPressed() {
        
        DispatchQueue.global().async {
            
            let originalImage = CIImage(image: self.selectedImage)
            guard let sepiaFilter = CIFilter(name: "CISepiaTone") else {
                fatalError("CISepiaTone not available!")
            }
            sepiaFilter.setValue(originalImage, forKey: kCIInputImageKey)
            sepiaFilter.setValue(1.0, forKey: kCIInputIntensityKey)
            let sepiaImage = UIImage(ciImage: sepiaFilter.outputImage!)
            
            DispatchQueue.main.async {
                self.imageView.image = sepiaImage
            }
        }
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = self.selectedImage
        self.imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func openCameraButtonDidPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Vacation Spots", message: "", preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take a Photo", style: .default) { (action :UIAlertAction) in
            
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        
        let pickFromLibraryAction = UIAlertAction(title: "Pick from Library", style: .default) { (action :UIAlertAction) in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(pickFromLibraryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    
    @IBAction func doneButtonDidPressed() {
        
        guard let newImage = self.imageView.image else {
            
            let noImageAlert = UIAlertController(title: "No Photo Selected", message: "Please choose a photo", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            noImageAlert.addAction(dismissAction)
            self.present(noImageAlert, animated: true, completion: nil)

            return
            
        }
        
        self.delegate.addImageDidSave(imageTitle: self.imageTitleTextField.text!, image: newImage)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonDidPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
