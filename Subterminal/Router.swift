//
//  Router.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 19/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
	case getAircraft()
	case getGear()
	
	case updateUser()
	
	static let baseURL = "http://192.168.1.11/api"
	
	var method: HTTPMethod {
		switch self {
		case .getAircraft(), .getGear():
			return .get
		case .updateUser():
			return .post
		}
	}
	
	var path: String {
		switch self {
		case .getAircraft():
			return "/aircraft"
			
		case .getGear():
			return "/user/gear"
		
		case .updateUser():
			return "/user"
		}
	}
	
	
	// MARK: URLRequestConvertible
	
	func asURLRequest() throws -> URLRequest {
		let url = try Router.baseURL.asURL()
		
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue
		
		switch self {
		case .getAircraft():
			urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
			
		case .updateUser():
			let data = try JSONSerialization.data(withJSONObject: ["token": Subterminal.user.facebook_token], options: [])
			urlRequest.httpBody = data
			
		case .getGear():
			urlRequest = try URLEncoding.default.encode(urlRequest, with: ["last_sync": "2001-01-01"])
			
		default:
			break
		}
		
		urlRequest.setValue(Subterminal.getKey(key: "apiaccept"), forHTTPHeaderField: "accept")
		urlRequest.setValue(Subterminal.getKey(key: "apikey"), forHTTPHeaderField: "apiappkey")
		
		if(Subterminal.user.isLoggedIn()) {
			urlRequest.setValue(Subterminal.user.facebook_token, forHTTPHeaderField: "sessionToken")
		}
		
		return urlRequest
	}
}
