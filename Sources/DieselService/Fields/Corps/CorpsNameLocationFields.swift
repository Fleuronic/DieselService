// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import struct Diesel.Location
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct CorpsNameLocationFields {
	public let id: Corps.ID
	public let name: String
	public let location: LocationBaseFields

	public init(
		id: Corps.ID,
		name: String,
		location: LocationBaseFields
	) {
		self.id = id
		self.name = name
		self.location = location
	}
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

// MARK: -
private extension CorpsNameLocationFields {
	init(
		id: Corps.ID,
		name: String,
		locationID: Location.ID,
		city: String,
		state: String
	) {
		self.id = id
		self.name = name

		location = .init(
			id: locationID,
			city: city,
			state: state
		)
	}
}
