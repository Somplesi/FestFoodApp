//
//  CoreMLHelper.swift
//  FestFoodApp
//
//  Created by Rodolphe DUPUYL on 09/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import UIKit
import Vision
import CoreML

class CoreMLHelper {
    
    private static let _analyse = CoreMLHelper()
    static var analyse: CoreMLHelper {
        return _analyse
    }
    
    var completion: ((String?) -> Void)?
    let erreurString = "Appuyez sur le burger pour choisir une image"
    
    func junkFood(_ image: UIImage?, completion: ((String?) -> Void)?) {
        self.completion = completion
        if let img = image {
            if let data = img.pngData() {
                do {
                    let config = MLModelConfiguration()
                    let modele = try VNCoreMLModel(for: MyImageClassifier(configuration: config).model)
                    let request = VNCoreMLRequest(model: modele, completionHandler: response)
                    let handler = VNImageRequestHandler(data: data, options: [:])
                    try handler.perform([request])
                } catch {
                    print(error.localizedDescription)
                    completion?(erreurString)
                }
            } else {
                completion?(erreurString)
            }
        } else {
            completion?(erreurString)
        }
    }
    
    func response(_ request: VNRequest, _error: Error?) {
        if let resultats = request.results as? [VNClassificationObservation] {
            if resultats.count > 0 {
                let bon = resultats[0]
                let confidence = " à \(Int(bon.confidence * 100))% de probabilité."
                let resultatString = "Selon CoreML, ceci est " +  bon.identifier + confidence
                completion?(resultatString)
            } else {
                completion?(erreurString)
            }
        } else {
            completion?(erreurString)
        }
    }
    
}
