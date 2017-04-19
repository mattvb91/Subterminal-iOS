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
	
	case getSkyGear(lastSync: String), getBaseGear(lastSync: String), getSkydives(lastSync: String), getSuits(lastSync: String),
		getJumps(lastSync: String), getExits(lastSync: String)
	
	case payment(token: String)
	case getPublicExits()
	
	case syncSkydive(model: Synchronizable), syncExit(model: Synchronizable), syncSkydiveRig(model: Synchronizable), syncSuit(model: Synchronizable),
	syncJump(model: Synchronizable), syncBaseRig(model: Synchronizable)
	
	case deleteSkydive(model: Synchronizable), deleteSuit(model: Synchronizable), deleteExit(model: Synchronizable), deleteJump(model: Synchronizable),
	deleteSkydiveGear(model: Synchronizable)
	
	case updateUser()
	
	static let baseURL = Subterminal.getKey(key: "api_url")
	
	var method: HTTPMethod {
		switch self {
			case .getAircraft, .getSkyGear, .getSkydives, .getSuits, .getPublicExits, .getExits, .getBaseGear, .getJumps:
				return .get
			
			case .updateUser, .payment:
				return .post

			case .syncSkydive( _), .syncExit( _), .syncSkydiveRig( _), .syncSuit( _), .syncJump( _), .syncBaseRig( _):
				return .post
			
			case .deleteSkydive( _), .deleteSuit( _), .deleteExit( _), .deleteJump( _), .deleteSkydiveGear( _):
				return .delete
		}
	}
	
	var path: String {
		switch self {
		case .getAircraft():
			return "/aircraft"
		
		//Skydive gear
		case .getSkyGear( _):
			return "/user/rigs"
			
		case .syncSkydiveRig( _):
			return "/rig"
			
		case .deleteSkydiveGear( _):
			return "/user/rigs/"
			
		case .getBaseGear( _):
			return "user/gear"
			
		//Skydives
		case .getSkydives( _):
			return "/user/skydives"
			
		case .syncSkydive( _):
			return "/skydive"
			
		case .deleteSkydive( _):
			return "/user/skydive/"
			
		//Suits
		case .getSuits( _):
			return "/user/suits"
			
		case .syncSuit( _):
			return "/suit"
		
		case .deleteSuit( _):
			return "/user/suit/"
			
		//Exits
		case .getExits( _):
			return "/user/exits"
			
		case .syncExit( _):
			return "/exit"
		
		case .deleteExit( _):
			return "/user/exit/"
			
		//Jumps
		case .getJumps( _):
			return "/user/jumps"
			
		case .syncJump( _):
			return "/jump"
			
		case .deleteJump( _):
			return "/user/jump/"
		
		case .getPublicExits():
			return "exit"
			
		case .updateUser():
			return "/user"
			
		case .payment(let _):
			return "/payment"
			
		case .syncBaseRig( _):
			return "/gear"
			
		}
	}
	
	
	// MARK: URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		
		//Remove cached responses
		URLCache.shared.removeAllCachedResponses()
		
		let url = try Router.baseURL.asURL()
		
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue
		
		switch self {
		case .getAircraft():
			urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
			
		case .updateUser():
			let data = try JSONSerialization.data(withJSONObject: ["token": Subterminal.user.facebook_token], options: [])
			urlRequest.httpBody = data
			
		case .getSkyGear(let lastSync), .getSkydives(let lastSync), .getSuits(let lastSync), .getExits(let lastSync), .getBaseGear(let lastSync), .getJumps(let lastSync):
			urlRequest = try URLEncoding.default.encode(urlRequest, with: ["last_sync": lastSync])
			
		case .payment(let token):
			let data = try JSONSerialization.data(withJSONObject: ["id": token], options: [])
			urlRequest.httpBody = data
			
		case .syncSkydive(let model), .syncExit(let model), .syncSkydiveRig(let model), .syncSuit(let model), .syncJump(let model), .syncBaseRig(let model):
			let data = try JSONSerialization.data(withJSONObject: model.toJSON(), options: [])
			urlRequest.httpBody = data
			
		case .deleteSkydive(let model), .deleteSuit(let model), .deleteExit(let model), .deleteJump(let model), .deleteSkydiveGear(let model):
			urlRequest.url?.appendPathComponent(model.id.description)
			
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
