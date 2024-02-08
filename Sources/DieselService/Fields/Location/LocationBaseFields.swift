// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Location
import struct Schemata.Projection

public struct LocationBaseFields {
	public let id: Location.ID

	let city: String
	let state: String
}

// MARK: -
extension LocationBaseFields: LocationFields {
	// MARK: ModelProjection
	public static let projection = Projection<Location.Identified, Self>(
		Self.init,
		\.id,
		\.value.city,
		\.value.state
	)
}
