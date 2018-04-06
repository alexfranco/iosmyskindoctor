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

// MARK: Constants

class ApiUtils {
	
	struct Api {
		static let DEV_BASE_URL = "https://boiling-chamber-30803.herokuapp.com"
		static let BASE_URL = "https://boiling-chamber-30803.herokuapp.com" // TODO
		
		static let TOKEN_TYPE = "Token"
		static let DEFAULT_STATUS_CODE: NSInteger = -1
	}
	
	enum ApiResult {
		case success(BaseMappable?)
		case failure(BaseMappable?, ApiGenericError)
	}
	
	enum ApiArrayResult {
		case success([BaseMappable?]?)
		case failure([BaseMappable?]?, ApiGenericError)
	}
	
	enum ApiGenericError: Error {
		case defaultStatusError
		case parseError
		case unknownError
		case httpQueryError
		case noErrors
		case permisionDenied
		case authorizationError
		case connectionError
	}
	
	enum ApiMethod: String {
		case login = "/api/accounts/login/"
		case register = "/api/accounts/register/"
		case forgottenPassword = "/api/accounts/password/reset/"
		case userProfile = "/api/msd-profiles/user/"
		case changePassword = "/api/accounts/password/change/"
		case logout = "/api/accounts/logout/"
		case accessCode = "/api/accounts/access-code/use/"
		case timeslots = "/api/consult/timeslots"
		case appointments = "/api/appointments/appointments/"
		case appointmentsCase = "/api/appointments/case/"
		case profileImage = "/api/accounts/patient/profile-image/"
		case topup = "/api/accounts/payments/topup/"
		
		case patientUpdate = "/api/accounts/patient/"
		case skinProblems = "/api/cases/case/"
		case skinProblemsImage = "image/"
		case skinProblemsSubmit = "submit/"
	}
}

// MARK: WebCalls

extension ApiUtils {
	
	static func login(email: String, password: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.login, nil)
		let params: Parameters =	["email": email,
									 "password": password]
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: LoginResponseModel.self, accessToken: nil, completionHandler: completionHandler)
	}
	
	static func registration(email: String, password: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.register, nil)
		let params: Parameters =	["email": email,
									 "password": password]
		
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
		if let dobSafe = dob { params.updateValue(dobSafe.iso8601WithoutTime, forKey: "date_of_birth") }
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
	
	static func updateProfileImage(accessToken: String, profileImageFilename: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		
		let url = ApiUtils.getApiUrl(ApiMethod.profileImage, nil)
		
		var params: Parameters = [:]
		params.updateValue(profileImageFilename, forKey: "file_name")
		ApiUtils.request(url: url, httpMethod: HTTPMethod.put, params: params, parseToModelType: ProfileResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	
	static func getProfile(accessToken: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.patientUpdate, nil)
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: ProfileResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func logoutUser(accessToken: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.logout, nil)
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: nil, parseToModelType: BaseResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getAllSkinProblems(accessToken: String, completionHandler: @escaping ((_ result: ApiArrayResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		
		ApiUtils.requestArray(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: SkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getSkinProblems(accessToken: String, skinProblemsId: Int, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/"
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: SkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func createSkinProblem(accessToken: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: nil, parseToModelType: SkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func deleteSkinProblem(accessToken: String, skinProblemsId: Int, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/"
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.delete, params: nil, parseToModelType: SkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func updateSkinProblems(accessToken: String, skinProblemsId: Int, skinProblemsDescription: String?, healthProblems: String?, medications: String?, history: String?, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/"
		
		var params: Parameters = [:]
		if let skinProblemsDescriptionSafe = skinProblemsDescription { params.updateValue(skinProblemsDescriptionSafe, forKey: "description") }
		if let healthProblemsSafe = healthProblems { params.updateValue(healthProblemsSafe, forKey: "health_problems") }
		if let medicationsSafe = medications { params.updateValue(medicationsSafe, forKey: "medications") }
		if let historySafe = history { params.updateValue(historySafe, forKey: "history") }
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.put, params: params, parseToModelType: SkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func createSkinProblemAttachment(accessToken: String, skinProblemsId: Int, location: String, filename: String?, description: String?, attachmentType: Int, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/\(ApiMethod.skinProblemsImage.rawValue)"
	
		var params: Parameters = [:]
		
		let attachmentTypeInt = attachmentType.hashValue
		
		params.updateValue(description ?? "-", forKey: "description")
		params.updateValue(filename ?? "-", forKey: "file_name")
		params.updateValue(attachmentTypeInt, forKey: "photo_type")
		params.updateValue(location, forKey: "photo_location")
					
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: SkinProblemAttachmentResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func deleteSkinProblemAttachment(accessToken: String, skinProblemsId: Int, attachmentId: Int, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/\(ApiMethod.skinProblemsImage.rawValue)\(attachmentId)"
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.delete, params: nil, parseToModelType: SkinProblemAttachmentResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func submitSkinProblem(accessToken: String, skinProblemsId: Int, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.skinProblems, nil)
		url += "\(skinProblemsId)/\(ApiMethod.skinProblemsSubmit.rawValue)"
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: nil, parseToModelType: SubmittedSkinProblemsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func accessCode(accessToken: String, accesscode: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.accessCode, nil)
		
		var params: Parameters = [:]
		params.updateValue(accesscode, forKey: "code")
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: AccessCodeResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getAllAppointments(accessToken: String, completionHandler: @escaping ((_ result: ApiArrayResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.appointments, nil)
		ApiUtils.requestArray(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: EventResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getTimeslots(accessToken: String, skinProblemsId: Int, startDate: Date, endDate: Date, completionHandler: @escaping ((_ result: ApiArrayResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.appointmentsCase, nil)
		url += "\(skinProblemsId)/"
		
		var params: Parameters = [:]
		params.updateValue(startDate.iso8601, forKey: "start")
		params.updateValue(endDate.iso8601, forKey: "end")
		
		ApiUtils.requestArray(url: url, httpMethod: HTTPMethod.get, params: params, parseToModelType: AppointmentsResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func createAppointment(accessToken: String, skinProblemsId: Int, startDate: Date, endDate: Date, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		var url = ApiUtils.getApiUrl(ApiMethod.appointmentsCase, nil)
		url += "\(skinProblemsId)/"
		
		var params: Parameters = [:]
		params.updateValue(startDate.iso8601, forKey: "timeslot")
		params.updateValue(endDate.iso8601, forKey: "end")
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: ConsultationResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func getCreditsOptions(accessToken: String, completionHandler: @escaping ((_ results: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.topup, nil)
		ApiUtils.request(url: url, httpMethod: HTTPMethod.get, params: nil, parseToModelType: TopupListResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
	
	static func payWithCreditCard(accessToken: String, stripeToken: String, optionId: Int, amount: String, credits: String, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		let url = ApiUtils.getApiUrl(ApiMethod.topup, nil)
		
		var params: Parameters = [:]
		params.updateValue(stripeToken, forKey: "token")
		params.updateValue(String(optionId), forKey: "option_id")
		params.updateValue(amount, forKey: "amount")
		params.updateValue(credits, forKey: "credits")
		
		ApiUtils.request(url: url, httpMethod: HTTPMethod.post, params: params, parseToModelType: CreditCardResponseModel.self, accessToken: accessToken, completionHandler: completionHandler)
	}
}

// MARK: Utils

extension ApiUtils {
	
	fileprivate class func getBaseUrl() -> String {
		#if DEV
			return Api.DEV_BASE_URL
		#else
			return Api.BASE_URL
		#endif
	}
	
	class func getDevId() -> String? {
		guard let deviceId = UIDevice.current.identifierForVendor else {
			return nil
		}
		
		guard let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String else {
			return nil
		}
		
		return "\(deviceId.uuidString)_\(appName)"
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
	
	fileprivate class func createHeaders(accessToken: String?) -> HTTPHeaders? {
		
		var headers: HTTPHeaders?

		if let accessTokenSafe = accessToken {
			headers = [
				"Authorization": "\(Api.TOKEN_TYPE) \(accessTokenSafe)",
				"Accept": "application/json"
			]
		}
		
		return headers
	}
	
	/* Generic Request
	  TODO add info
	*/
	fileprivate class func request<T: BaseMappable>(url: String, httpMethod: HTTPMethod, params: Parameters?, parseToModelType: T.Type, accessToken: String?, completionHandler: @escaping ((_ result: ApiResult) -> Void)) {
		
		Alamofire.request(url, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: createHeaders(accessToken: accessToken)).responseJSON { (response) in
			if let jsonCandidate = response.result.value {
				print("JSON: \(jsonCandidate)") // serialized json response
				
				if jsonCandidate is NSNull && response.response?.statusCode == 204 {
					completionHandler(ApiResult.success(nil))
					return
				}
				
				let jsonCandidateDict = jsonCandidate as! [String : Any]
				
				if let jsonResult = Mapper<T>().map(JSON: jsonCandidateDict) {
					
					if let status = response.response?.statusCode {
						switch(status){
						case 200, 201, ApiUtils.Api.DEFAULT_STATUS_CODE:
							completionHandler(ApiResult.success(jsonResult))
						case 401:
							completionHandler(ApiResult.failure(nil, ApiGenericError.authorizationError))
						case 403:
							completionHandler(ApiResult.failure(nil, ApiGenericError.permisionDenied))
						default:
							print("error with response status: \(status)")
							completionHandler(ApiResult.failure(jsonResult, ApiGenericError.defaultStatusError))
						}
					}
				} else {
					completionHandler(ApiResult.failure(nil, ApiGenericError.authorizationError))
				}
			} else {
				completionHandler(ApiResult.failure(nil, ApiGenericError.httpQueryError))
			}
		}
	}
	
	fileprivate class func requestArray<T: BaseMappable>(url: String, httpMethod: HTTPMethod, params: Parameters?, parseToModelType: T.Type, accessToken: String?, completionHandler: @escaping ((_ result: ApiArrayResult) -> Void)) {
		
		Alamofire.request(url, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: createHeaders(accessToken: accessToken)).responseJSON { (response) in
			if let jsonCandidate = response.result.value {
				print("JSON: \(jsonCandidate)") // serialized json response
				
				if let jsonResult = Mapper<T>().mapArray(JSONObject: jsonCandidate) {
					
					if let status = response.response?.statusCode {
						switch(status){
						case 200, 201, ApiUtils.Api.DEFAULT_STATUS_CODE:
							completionHandler(ApiArrayResult.success(jsonResult))
						case 401:
							completionHandler(ApiArrayResult.failure(nil, ApiGenericError.authorizationError))
						case 403:
							completionHandler(ApiArrayResult.failure(nil, ApiGenericError.permisionDenied))
						default:
							print("error with response status: \(status)")
							completionHandler(ApiArrayResult.failure(jsonResult, ApiGenericError.defaultStatusError))
						}
					}
				} else {
					completionHandler(ApiArrayResult.failure(nil, ApiGenericError.authorizationError))
				}
			} else {
				completionHandler(ApiArrayResult.failure(nil, ApiGenericError.httpQueryError))
			}
		}
	}
}
