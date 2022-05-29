//
//  SignatureViewController.swift
//  iOS13Experiments
//
//  Created by GauravSharma on 30/10/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit
import PencilKit
import CoreHaptics
import AudioToolbox

class SignatureViewController: UIViewController {
    let canvasView = PKCanvasView.init(frame: .zero)
    @IBOutlet weak var stackView: UIStackView!
   
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureInitialViews()
    }

    func configureInitialViews() {
        canvasView.allowsFingerDrawing = true
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvasView)
        
        NSLayoutConstraint.activate([canvasView.topAnchor.constraint(equalTo: stackView.bottomAnchor),                                       canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),                                         canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),                                       canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        guard let window = view.window, let toolPicker = PKToolPicker.shared(for: window) else { return }
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
        
    @IBAction func saveButtonSelected(_ sender: Any) {
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        UIImageWriteToSavedPhotosAlbum(image, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Image saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    @objc func showSavedSuccessfullyAlert() {
        let ac = UIAlertController(title: title, message: "Saved Successfully.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { alert in

        }))
        present(ac, animated: true)
    }
    
    @IBAction func toggleButtonSelected(_ sender: Any) {
        if canvasView.isFirstResponder{
            canvasView.resignFirstResponder()
        }else{
            canvasView.becomeFirstResponder()
        }
    }
    
    @IBAction func clearButtonSelected(_ sender: Any) {
        canvasView.drawing = PKDrawing()
    }
    
    // MARK:- Touch Events for Heptics
}
