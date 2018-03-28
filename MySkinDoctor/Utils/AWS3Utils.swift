//
//  AWS3Utils.swift
//  MySkinDoctor
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import AWSS3

class AWS3Utils: NSObject {

	// AWS3
	enum ApiWS3Result {
		case success(filename: String?)
		case failure(error: ApiUtils.ApiGenericError)
	}
	
	static let aws3Bucket = "skindoctor-private"
	
	static func storeImage(image: UIImage) -> String {
		// Upload to Amazon S3
		// Create filename
		let filename: String = UUID().uuidString + ".jpg"
		
		// Convert file to jpg
		let imageData: Data? = UIImageJPEGRepresentation(image, 0.6)
		let path = NSTemporaryDirectory() + filename
		try? imageData?.write(to: URL(fileURLWithPath: path), options: [.atomic])
		return filename
	}
	
	static func uploadImageToS3(filename: String, completionHandler: @escaping ((_ result: ApiWS3Result) -> Void)) {
		// Once the image is saved, we can use the path to create a local file URL
		let path = NSTemporaryDirectory() + filename
		let url: URL = URL.init(fileURLWithPath: path)
		
		// Upload to Amazon AWS S3
		let aws3Bucket = self.aws3Bucket
		let uploadRequest: AWSS3TransferManagerUploadRequest = AWSS3TransferManagerUploadRequest.init()
		uploadRequest.bucket = aws3Bucket
		uploadRequest.key = filename // Name of file
		uploadRequest.body = url
		
		// For testing only:
		print(filename)
		print(url)
		
		let transferManager: AWSS3TransferManager = AWSS3TransferManager.default()
		transferManager.upload(uploadRequest).continue(with: AWSExecutor.mainThread(), with: { (task) -> AnyObject? in
			// Once upload complete
			if let error = task.error {
				print(error)
				
				if error._code == -1009 {
					completionHandler(ApiWS3Result.failure(error: ApiUtils.ApiGenericError.connectionError))
				}
			}
			
			if let result = task.result {
				// The file uploaded successfully
				let uploadOutput: AWSS3TransferManagerUploadOutput = result as! AWSS3TransferManagerUploadOutput
				print(uploadOutput)
				
				completionHandler(ApiWS3Result.success(filename: filename))
			} else {
				completionHandler(ApiWS3Result.failure(error: ApiUtils.ApiGenericError.unknownError))
			}
			
			return nil
		})
	}

}
