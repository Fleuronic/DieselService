// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

import struct Diesel.Location
import protocol Identity.Identifiable
import struct Schemata.Projection

@Init public struct LocationBaseFields {
	public let id: Location.ID
	public let city: String
	public let state: String
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
