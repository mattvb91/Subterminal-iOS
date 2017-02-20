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
	
	static let baseURL = "http://192.168.1.11/api"
	
	var method: HTTPMethod {
		switch self {
		case .getAircraft():
			return .get
		}
	}
	
	var path: String {
		switch self {
		case .getAircraft():
			return "/aircraft"
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
		default:
			break
		}
		
		urlRequest.setValue(Subterminal.getKey(key: "apiaccept"), forHTTPHeaderField: "accept")
		urlRequest.setValue(Subterminal.getKey(key: "apikey"), forHTTPHeaderField: "apiappkey")
		
		return urlRequest
	}
}
