// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Catena.IDFields
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol EventFields: Fields where Model == Event.Identified {}

// MARK: -
extension IDFields<Event.Identified>: EventFields {}

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
