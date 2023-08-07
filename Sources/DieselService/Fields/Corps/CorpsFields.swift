// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol CorpsFields: Fields where Model == Corps.Identified {}

// MARK: -
extension Corps.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case location
	}
}
