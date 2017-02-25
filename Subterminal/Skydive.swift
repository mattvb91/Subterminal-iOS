//
//  Skydive.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Skydive: Synchronizable {
    
    //MARK: Properties
    dynamic var skydive_description: String?
    dynamic var date: Date?
    
	dynamic var dropzone_id,
		exit_altitude,
        deploy_altidude,
        delay,
        jump_type,
        aircraft_id,
        rig_id,
        suid_id: NSNumber?
	
    dynamic var height_unit: NSNumber = 0
	
	//Skydive Types
	static let SKYDIVE_TYPE_BELLY = 1;
	static let SKYDIVE_TYPE_FREEFLY = 2;
	static let SKYDIVE_TYPE_HYBRID = 3;
	static let SKYDIVE_TYPE_WINGSUIT = 4;
	static let SKYDIVE_TYPE_TRACKING = 5;
	static let SKYDIVE_TYPE_ANGLE = 6;
	static let SKYDIVE_TYPE_HEADUP = 7;
	static let SKYDIVE_TYPE_HEADDOWN = 8;
	static let SKYDIVE_TYPE_BIGWAY = 9;
	static let SKYDIVE_TYPE_FREESTYLE = 10;
	static let SKYDIVE_TYPE_FORMATION = 11;
	
	static let SKYDIVE_TYPE_CANOPY_SWOOP = 20;
	static let SKYDIVE_TYPE_CANOPY_ACCURACY = 21;
	static let SKYDIVE_TYPE_CANOPY_HOPNPOP = 22;
	static let SKYDIVE_TYPE_CANOPY_CREW = 23;
	static let SKYDIVE_TYPE_CANOPY_CROSSCOUNTRY = 24;
	static let SKYDIVE_TYPE_CANOPY_HIGHPULL = 25;
	static let SKYDIVE_TYPE_CANOPY_XRW = 26;
	static let SKYDIVE_TYPE_CANOPY_FLAG = 27;
	
	static let SKYDIVE_TYPE_VIDEO = 40;
	
	static let SKYDIVE_TYPE_INSTRUCTOR_TANDEM = 50;
	static let SKYDIVE_TYPE_INSTRUCTOR_AFF = 51;
	static let SKYDIVE_TYPE_INSTRUCTOR_LOADORGANIZER = 52;
	static let SKYDIVE_TYPE_INSTRUCTOR_COACH = 53;
	static let SKYDIVE_TYPE_INSTRUCTOR_STATICLINE = 54;
	
	static let SKYDIVE_TYPE_MILITARY_HALO = 60;
	static let SKYDIVE_TYPE_MILITARY_SLICK = 61;
	static let SKYDIVE_TYPE_MILITARY_COMBAT = 62;
	
	static let SKYDIVE_TYPE_OTHER_NAKED = 70;
	static let SKYDIVE_TYPE_OTHER_NIGHT = 71;
	static let SKYDIVE_TYPE_OTHER_MR_BILL = 72;
	static let SKYDIVE_TYPE_OTHER_DEMO = 73;
	
	static let SKYDIVE_TYPE_STUDENT_AFF = 80;
	static let SKYDIVE_TYPE_STUDENT_STATICLINE = 81;
	static let SKYDIVE_TYPE_STUDENT_TANDEM = 82;
	static let SKYDIVE_TYPE_STUDENT_CONSOLE = 83;
	
	static var types = [
		SKYDIVE_TYPE_BELLY: "Belly",
		SKYDIVE_TYPE_FREEFLY: "Freefly",
		SKYDIVE_TYPE_HYBRID: "Hybrid",
		SKYDIVE_TYPE_WINGSUIT: "Wingsuit",
		SKYDIVE_TYPE_TRACKING: "Tracking",
		SKYDIVE_TYPE_ANGLE: "Angle",
		SKYDIVE_TYPE_HEADUP: "Headup",
		SKYDIVE_TYPE_HEADDOWN: "Headdown",
		SKYDIVE_TYPE_BIGWAY: "Bigway",
		SKYDIVE_TYPE_FREESTYLE: "Freestyle",
		SKYDIVE_TYPE_FORMATION: "Formation",
		
		SKYDIVE_TYPE_CANOPY_SWOOP: "Canopy - Swoop",
		SKYDIVE_TYPE_CANOPY_ACCURACY: "Canopy - Accuracy",
		SKYDIVE_TYPE_CANOPY_HOPNPOP: "Canopy - Hop-n-Pop",
		SKYDIVE_TYPE_CANOPY_CREW: "Canopy - CReW",
		SKYDIVE_TYPE_CANOPY_CROSSCOUNTRY: "Canopy - Cross Country",
		SKYDIVE_TYPE_CANOPY_HIGHPULL: "Canopy - High Pull",
		SKYDIVE_TYPE_CANOPY_XRW: "Canopy - XRW",
		SKYDIVE_TYPE_CANOPY_FLAG: "Canopy - Flag",
		
		SKYDIVE_TYPE_VIDEO: "Video",
		
		SKYDIVE_TYPE_INSTRUCTOR_TANDEM: "Instructor - Tandem",
		SKYDIVE_TYPE_INSTRUCTOR_AFF: "Instructor - AFF",
		SKYDIVE_TYPE_INSTRUCTOR_LOADORGANIZER: "Instructor - Load Organizer",
		SKYDIVE_TYPE_INSTRUCTOR_COACH: "Instructor - Coach",
		SKYDIVE_TYPE_INSTRUCTOR_STATICLINE: "Instructor - Static Line",
		
		SKYDIVE_TYPE_MILITARY_HALO: "Military - HALO ",
		SKYDIVE_TYPE_MILITARY_SLICK: "Military - Slick ",
		SKYDIVE_TYPE_MILITARY_COMBAT: "Military - Combat",
		
		SKYDIVE_TYPE_OTHER_NAKED: "Other - Naked",
		SKYDIVE_TYPE_OTHER_NIGHT: "Other - Night",
		SKYDIVE_TYPE_OTHER_MR_BILL: "Other - Mr. Bill",
		SKYDIVE_TYPE_OTHER_DEMO: "Other - Demo",
		
		SKYDIVE_TYPE_STUDENT_AFF: "Student - AFF",
		SKYDIVE_TYPE_STUDENT_STATICLINE: "Student - Static Line",
		SKYDIVE_TYPE_STUDENT_TANDEM: "Student - Tandem",
		SKYDIVE_TYPE_STUDENT_CONSOLE: "Student - Console",
	]
	
	func aircraft() -> Aircraft? {
		if self.aircraft_id != nil {
			return (Aircraft.object(withPrimaryKeyValue: self.aircraft_id) as? Aircraft)!
		}
		
		return nil
	}
	
	func dropzone() -> Dropzone? {
		if self.dropzone_id != nil {
			return (Dropzone.object(withPrimaryKeyValue: self.dropzone_id) as? Dropzone)!
		}
		
		return nil
	}
	
	func rig() -> Rig? {
		if self.rig_id != nil, self.rig_id?.intValue != 0 {
			return (Rig.object(withPrimaryKeyValue: self.rig_id) as? Rig)!
		}
		
		return nil
	}
	
	//Get the skydive types available for select
	static func getTypesForSelect() -> [String] {
		var results = [String]()
		
		for type in types {
			results.append(type.value)
		}
		
		return results
	}
	
	//Use this to get associated keys from indexes
	static func getKeysForTypes() -> [Int] {
		var results = [Int]()
		
		for type in types {
			results.append(type.key)
		}
		
		return results
	}
	
	//Get the formatted type string if we have an associated jump type value
	func getFormattedType() -> String? {
		if self.jump_type != nil {
			return Skydive.types[(self.jump_type?.intValue)!]!
		}
		
		return nil
	}
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		return Router.getSkydives()
	}
	
	override  func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.getSkydives()
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getSkydives()
	}
	
	override  func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	override  class func build(json: JSON) -> Skydive {
		let skydive = Skydive()
			
		skydive.id = json["remote_id"].intValue as NSNumber!
		skydive.date = DateHelper.stringToDate(string: json["date"].stringValue)
		skydive.dropzone_id = json["dropzone_id"].intValue as NSNumber!
		skydive.exit_altitude = json["exit_altitude"].intValue as NSNumber!
		skydive.deploy_altidude = json["deploy_altitude"].intValue as NSNumber!
		skydive.delay = json["delay"].intValue as NSNumber!
		skydive.jump_type = json["jump_type"].intValue as NSNumber!
		skydive.aircraft_id = json["aircraft_id"].intValue as NSNumber!
		skydive.rig_id = json["rig_id"].intValue as NSNumber!
		skydive.height_unit = json["height_unit"].intValue as NSNumber!
		skydive.suid_id = json["suit_id"].intValue as NSNumber!
		skydive.skydive_description = json["description"].stringValue

		return skydive
	}
}
