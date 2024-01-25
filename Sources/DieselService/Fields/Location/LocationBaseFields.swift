// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Location
import struct Schemata.Projection
import protocol Identity.Identifiable

struct LocationBaseFields {
	let id: Location.ID
	let city: String
	let state: String
}

// MARK: -
extension LocationBaseFields: LocationFields {
	// MARK: ModelProjection
	static let projection = Projection<Location.Identified, Self>(
		Self.init,
		\.id,
		\.value.city,
		\.value.state
	)
}
