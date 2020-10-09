//
//  AlertHelper.swift
//  FestFoodApp
//
//  Created by Rodolphe DUPUYL on 09/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import UIKit

class AlerteHelper {
    
    private static let _montrer = AlerteHelper()
    
    static var montrer: AlerteHelper {
        return _montrer
    }
    
    func choixCamera(controller: CameraController, picker: UIImagePickerController) {
        
        let alerte = UIAlertController(title: "Prendre une photo", message: "Quel média voulez-vous utiliser?", preferredStyle: .actionSheet) // ActionSheet
        
        // Camera choisie
        // Ajouter dans plist: Privacy - Camera Usage Description
        let camera = UIAlertAction(title: "Appareil Photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                controller.present(picker, animated: true, completion: nil)
            } else {
                self.erreur(controller: controller, erreur: "L'appareil photo n'est pas disponible")
            }
        }
        
        // Gallerie choisie
        // Ajouter dans plist: Privacy - Photo Library Usage Description
        let gallery = UIAlertAction(title: "Gallerie de photos", style: .default) { (action) in
            picker.sourceType = .photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }
        
        // Cancel
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        // Ajouter les choix
        alerte.addAction(camera)
        alerte.addAction(gallery)
        alerte.addAction(cancel)
        
        // Cas de l'iPad uniquement
        if let iPadPop = alerte.popoverPresentationController {
            iPadPop.sourceView = controller.view
            iPadPop.sourceRect = CGRect(x: controller.view.frame.midX, y: controller.view.frame.midY, width: 0, height: 0)
            iPadPop.permittedArrowDirections = []
        }
        
        // Afficher l'ActionSheet
        controller.present(alerte, animated: true, completion: nil)
    }
    
    func erreur(controller: CameraController, erreur: String) {
        let alerte = UIAlertController(title: "Erreur", message: erreur, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alerte.addAction(ok)
        controller.present(alerte, animated: true, completion: nil)
    }
    
}
