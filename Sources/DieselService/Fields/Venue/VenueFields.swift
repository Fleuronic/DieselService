// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Venue
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol VenueFields: Fields where Model == Venue.Identified {}

// MARK: -
public extension Venue.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case address
	}
}
