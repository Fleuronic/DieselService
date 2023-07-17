// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Location
import protocol Identity.Identifiable

public struct LocationAllFields {
	public let id: Location.ID
	public let city: String
	public let state: String
}

// MARK: -
extension LocationAllFields: LocationFields {
	// MARK: ModelProjection
	public static let projection = Projection<Location.Identified, Self>(
		Self.init,
		\.id,
		\.value.city,
		\.value.state
	)
}
