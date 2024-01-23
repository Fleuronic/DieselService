// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import struct Diesel.Location
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct CorpsBaseFields {
	public let id: Corps.ID
	public let name: String
	public let location: IDFields<Location.Identified>
}

extension CorpsBaseFields: CorpsFields {
	// MARK: ModelProjection
	public static let projection = Projection<Corps.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.location.id
	)
}

// MARK: -
private extension CorpsBaseFields {
	init(
		id: Corps.ID,
		name: String,
		locationID: Location.ID
	) {
		self.id = id
		self.name = name

		location = .init(id: locationID)
	}
}
