//
//  PhotoViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoViewControllerDelegate : NSObjectProtocol {
	func photoViewController(_ photoViewController: PhotoViewController, imageChanged: UIImage)
}

class PhotoViewController: FormViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var userPhotoImageView: UIImageView!
	
	weak open var delegate: PhotoViewControllerDelegate?
	
	var pickerController = UIImagePickerController()
	var imageView = UIImage()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
		imageTapGesture.delegate = self
		userPhotoImageView.addGestureRecognizer(imageTapGesture)
		imageTapGesture.numberOfTapsRequired = 1
		userPhotoImageView.isUserInteractionEnabled = true
		pickerController.delegate = self
		
		userPhotoImageView.setRounded()
	}
	
	@objc func tapUserPhoto(_ sender: UITapGestureRecognizer?) {
		let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
		let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
			self.openCamera()
		})
		let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
			self.openGallery()
		}
		let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
			
		}
		alertViewController.addAction(camera)
		alertViewController.addAction(gallery)
		alertViewController.addAction(cancel)
		self.present(alertViewController, animated: true, completion: nil)
	}
	
	func openCamera() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			pickerController.delegate = self
			self.pickerController.sourceType = UIImagePickerControllerSourceType.camera
			pickerController.allowsEditing = true
			self.present(self.pickerController, animated: true, completion: nil)
		}
		else {
			showAlertView(title: "Warning", message: "You don't have camera")
		}
	}
		
	func openGallery() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
			pickerController.delegate = self
			pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
			pickerController.allowsEditing = true
			self.present(pickerController, animated: true, completion: nil)
		}
	}
		
	// MARK: UIImagePickerControllerDelegate
		
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		imageView = info[UIImagePickerControllerEditedImage] as! UIImage
		userPhotoImageView.contentMode = .scaleAspectFill
		userPhotoImageView.image = imageView
		
		if delegate != nil {
			delegate?.photoViewController(self, imageChanged: imageView)
		}
		
		dismiss(animated:true, completion: nil)
	}
		
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("Cancel")
	}
}
