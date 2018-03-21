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
		static let DEV_BASE_URL = "https://boiling-chamber-30803.herokuapp.com/"
		static let BASE_URL = "https://msd-dev.ttad-consultations.com" // TODO
		
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
		case userProfile = "/api/msd-profiles/user/"
		case changePassword = "/api/accounts/password/change/"
		
		case patientUpdate = "/api/accounts/patient/"
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
	
	static func registration(email: String, password: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.register, nil)
		let params: Parameters =	["email": email,
									 "accept_tos": true,
									 "first_name": "Alex",
									 "last_name": "Franco",
									 "password1": password,
									 "password2": password]
	
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: RegistrationResponseModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func forgotPassword(email: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.forgottenPassword, nil)
		let params: Parameters =	["email": email]
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: ForgotPasswordResposeModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func changePassword(oldPassword: String, newPassword: String, confirmPassowrd: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.changePassword, nil)
		let params: Parameters =	["old_password": oldPassword,
									 "new_password1": newPassword,
									 "new_password2": confirmPassowrd]
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: ChangePasswordResponseModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func updateProfile(accessToken: String, firstName: String?, lastName: String?, dob: Date?, phone: String?, addressLine1: String?, addressLine2: String?, town: String?, postcode: String?, gpName: String?, gpAddress: String?, gpPostCode: String?, gpContactPermission: Bool?, selfPay: Bool?, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		
		let url = ApiUtils.getApiUrl(ApiMethod.patientUpdate, nil)
		
		var params: Parameters = [:]
		
		if let firstNameSafe = firstName { params.updateValue(firstNameSafe, forKey: "first_name") }
		if let lastNameSafe = lastName { params.updateValue(lastNameSafe, forKey: "last_name") }
		if let dobSafe = dob { params.updateValue(dobSafe.toIso(), forKey: "date_of_birth") }
		if let phoneSafe = phone { params.updateValue(phoneSafe, forKey: "mobile_number") }
		if let addressLine1Safe = addressLine1 { params.updateValue(addressLine1Safe, forKey: "address_line_1") }
		if let addressLine2Safe = addressLine2 { params.updateValue(addressLine2Safe, forKey: "address_line_2") }
		if let townSafe = town { params.updateValue(townSafe, forKey: "town") }
		if let postcodeSafe = postcode { params.updateValue(postcodeSafe, forKey: "postcode") }
		if let gpNameSafe = gpName { params.updateValue(gpNameSafe, forKey: "gp_name") }
		if let gpAddressSafe = gpAddress { params.updateValue(gpAddressSafe, forKey: "gp_address") }
		if let gpPostCodeSafe = gpPostCode { params.updateValue(gpPostCodeSafe, forKey: "gp_postcode") }
		if let gpContactPermissionSafe = gpContactPermission { params.updateValue(gpContactPermissionSafe, forKey: "gp_contact_permission") }
		if let selfPaySafe = selfPay { params.updateValue(selfPaySafe, forKey: "self_pay") }
		
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.patch, params: params, parseToModelType: ProfileResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getProfile(accessToken: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		
		let url = ApiUtils.getApiUrl(ApiMethod.patientUpdate, nil)
		ApiUtils.request(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: ProfileResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
}
