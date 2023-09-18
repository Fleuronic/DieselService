// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Location
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct LocationBaseFields {
	public let id: Location.ID
	public let city: String
	public let state: String

	public init(
		id: Location.ID,
		city: String,
		state: String
	) {
		self.id = id
		self.city = city
		self.state = state
	}
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
