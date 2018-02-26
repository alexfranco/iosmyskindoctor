//
//  PhotoUtils.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class PhotoUtils: NSObject, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var pickerController = UIImagePickerController()
	var imageView = UIImage()
	var viewController: UIViewController?
	
	var completionHandler :  ((_ success: Bool,_ image: UIImage?) -> Void)?
	
	required init(inViewController: UIViewController) {
		super.init()
		self.viewController = inViewController
	}

	func showChoosePhoto(completionHandler: @escaping ((_ success: Bool,_ image: UIImage?) -> Void)) {
		self.completionHandler = completionHandler
		
		let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
		let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
			self.openCamera()
		})
		let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
			self.openGallery()
		}
		let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
			completionHandler(false, nil)
		}
		alertViewController.addAction(camera)
		alertViewController.addAction(gallery)
		alertViewController.addAction(cancel)
		
		viewController?.present(alertViewController, animated: true, completion: nil)
	}
	
	func openCamera() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			pickerController.delegate = self
			self.pickerController.sourceType = UIImagePickerControllerSourceType.camera
			pickerController.allowsEditing = true
			viewController?.present(self.pickerController, animated: true, completion: nil)
		}
		else {
			viewController?.showAlertView(title: "Warning", message: "You don't have camera")
		}
	}
	
	func openGallery() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
			pickerController.delegate = self
			pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
			pickerController.allowsEditing = true
			viewController?.present(pickerController, animated: true, completion: nil)
		}
	}
	
	// MARK: UIImagePickerControllerDelegate
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		imageView = info[UIImagePickerControllerEditedImage] as! UIImage
		picker.dismiss(animated:true, completion: nil)
		
		completionHandler!(true, imageView)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("Cancel")
		completionHandler!(false, nil)
	}
	
}
