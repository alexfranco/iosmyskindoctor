//
//  ApiUtils.swift
//  MySkinDoctor
//
//  Created by Alex on 16/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiUtils {
	
	struct Api {
		static let BASE_URL = "https://msd-dev.ttad-consultations.com" // TODO
		static let DEV_BASE_URL = "https://msd-dev.ttad-consultations.com"
		
		static let TOKEN_TYPE = "Token"
		static let DEFAULT_STATUS_CODE: NSInteger = -1
	}
	
	enum ApiResult {
		case success(BaseMappable?)
		case failure(BaseMappable?, ApiGenericError)
	}
	
	enum ApiGenericError: Error {
		case defaultStatusError
		case parseError
		case unknownError
		case httpQueryError
		case noErrors
	}
	
	enum ApiMethod: String {
		case login = "/api/accounts/login/"
		case register = "/api/accounts/register"
		case forgottenPassword = "/api/accounts/password/reset/"
		case userProfile = "/api/ttul-profiles/user/"
		case changePassword = "/api/accounts/password/change/"
	}
	
	fileprivate class func getBaseUrl() -> String {
		#if DEV
			return Api.DEV_BASE_URL
		#else
			return Api.BASE_URL
		#endif
	}
	
	fileprivate class func getApiUrl(_ method: ApiMethod, _ restParams: [String]?) -> String {
		if let params = restParams {
			switch (params.count) {
			case 1:
				// If 1 parameter
				if let params = restParams, params.count > 0 {
					let path = String(format: method.rawValue, arguments: [params[0]])
					return "\(getBaseUrl())\(path)"
				}
				fallthrough
				
			default:
				return "\(getBaseUrl())\(method.rawValue)"
			}
		}
		return "\(getBaseUrl())\(method.rawValue)"
	}
	
	/* Generic Request
	  TODO add info
	*/
	fileprivate class func request<T: BaseMappable>(url: String, httpMethod: HTTPMethod, params: Parameters?, parseToModelType: T.Type, accessToken: String?, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var headers: HTTPHeaders?
		
		if let accessTokenSafe = accessToken {
			headers = [
				"Authorization": "\(Api.TOKEN_TYPE) \(accessTokenSafe)",
				"Accept": "application/json"
			]
		}
		
		Alamofire.request(url, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result
			
			if let jsonCandidate = response.result.value {
				print("JSON: \(jsonCandidate)") // serialized json response
				
				let jsonCandidateDict = jsonCandidate as! [String : Any]
				
				if let jsonResult = Mapper<T>().map(JSON: jsonCandidateDict) {
					
					if let status = response.response?.statusCode {
						switch(status){
						case 200, 201, ApiUtils.Api.DEFAULT_STATUS_CODE:
							completionHandler(ApiResult.success(jsonResult))
						default:
							print("error with response status: \(status)")
							completionHandler(ApiResult.failure(jsonResult, ApiGenericError.defaultStatusError))
						}
					}
				} else {
					completionHandler(ApiResult.failure(nil, ApiGenericError.parseError))
				}
			} else {
				completionHandler(ApiResult.failure(nil, ApiGenericError.httpQueryError))
			}
		}
	}
	
	static func login(email: String, password: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.login, nil)
		let params: Parameters =	["email": email,
									 "password": password]
		
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: LoginResponseModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func registration(email: String, password: String, firstName: String, lastName: String, dob: Date, mobileNumber: String, postcode: String, deviceID: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {		
		let url = ApiUtils.getApiUrl(ApiMethod.register, nil)
		let params: Parameters =	["email": email,
									 "password": password,
									 "firstName": firstName,
									 "lastName": lastName,
									 "dob": dob,
									 "mobileNumber": mobileNumber,
									 "postcode": postcode,
									 "deviceID": deviceID]
		
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: RegistrationResponseModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func forgotPassword(email: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.forgottenPassword, nil)
		let params: Parameters =	["email": email]
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: ForgotPasswordResposeModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
}
