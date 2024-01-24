// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import struct Diesel.Location
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct CorpsNameLocationFields {
	public let id: Corps.ID
	public let name: String
	public let locationID: Location.ID
	public let city: String
	public let state: String
}

// MARK: -
extension CorpsNameLocationFields: CorpsFields {
	// MARK: ModelProjection
	public static let projection = Projection<Corps.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.location.id,
		\.location.value.city,
		\.location.value.state
	)
}
