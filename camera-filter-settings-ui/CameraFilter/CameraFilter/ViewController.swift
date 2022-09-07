//
//  ViewController.swift
//  CameraFilter
//
//  Created by Mohammad Azam on 2/13/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var img_Image: UIImageView!
    @IBOutlet weak var btn_ApplyButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_ApplyButton.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let photoNavVC = navC.viewControllers.first as? PhotosCollectionViewController
        else {
            fatalError("Segue destination is not found")
        }
        
        photoNavVC.selectedPhoto.subscribe { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(image: photo)
            }
            
        }.disposed(by: self.disposeBag)
    }
    
    @IBAction func onApllyFilterAction(_ sender: UIButton) {
        guard let sourcedIamge = self.img_Image.image else { return }
        
        FilterService().applyFilter(to: sourcedIamge)
            .subscribe { filteredImage in
                DispatchQueue.main.async {
                    self.img_Image.image = filteredImage
                }
            }.disposed(by: self.disposeBag)
    }
    
    
    private func updateUI(image: UIImage) {
        self.img_Image.image = image
        self.btn_ApplyButton.isHidden = false
    }
}

