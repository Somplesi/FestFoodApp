//
//  ViewController.swift
//  FestFoodApp
//
//  Created by Rodolphe DUPUYL on 09/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import UIKit

class CameraController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    let alertHelper = AlerteHelper.montrer
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        picker.allowsEditing = false
    }

    @IBAction func takePicture(_ sender: Any) {
        alertHelper.choixCamera(controller: self, picker: picker) // Choix de la Photo
    }
}


// MARK: Delegate Picker
extension CameraController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originale = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.imageView.image = originale
            }
        }
        
        dismiss(animated: true) {
            //Appeler la fonction pour faire une requete CoreML
            CoreMLHelper.analyse.junkFood(self.imageView.image, completion: { (string) in
                DispatchQueue.main.async {
                    if string != nil {
                        self.predictionLabel.text = string!
                    }
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
