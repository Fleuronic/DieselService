// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Event
import protocol Schemata.ModelProjection

public protocol EventFields: Fields where Model == Event.Identified {}

// MARK: -
public extension Event.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case show
		case slug
		case date
		case timeZone
		case location
		case venue
		case slots
	}
}
