//
//  ViewController.swift
//  TouchEvent
//
//  Created by 柘植俊之介 on 2024/09/16.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    @IBOutlet var backgroundImageView: UIImageView!
    var selectedImageName: String = "flower"
    var imageViewArray: [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: view)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imageView.image = UIImage (named: selectedImageName )
        imageView.center = CGPoint(x: location.x, y: location.y)
        view.addSubview(imageView)
        imageViewArray.append(imageView)
    }
    
    @IBAction func selectImage1(){
        selectedImageName = "flower"
    }
    @IBAction func selectImage2(){
        selectedImageName = "cloud"
    }
    @IBAction func selectImage3(){
        selectedImageName = "heart"
    }
    @IBAction func selectImage4(){
        selectedImageName = "star"
    }
    @IBAction func save(){
        UIGraphicsBeginImageContextWithOptions(backgroundImageView.frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -backgroundImageView.frame.origin.x, y: -backgroundImageView.frame.origin.y)
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext ()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //選択された画像の情報を取得
        let itemProvider = results.first?.itemProvider
        //選択された画像を読み込む
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image as? UIImage
                }}} 
        dismiss(animated: true)
    }
        
    @IBAction func changebackground(){
        //PHPickerViewController&Ha
        var configuration = PHPickerConfiguration ()
        let filter = PHPickerFilter.images
        configuration.filter = filter
        let picker = PHPickerViewController(configuration: configuration)
        //デリゲートを設定
        picker.delegate = self
        present(picker, animated: true)
    }
    @IBAction func undo(){
        if imageViewArray.isEmpty{return}
        imageViewArray.last!.removeFromSuperview()
        imageViewArray.removeLast()
    }
}

