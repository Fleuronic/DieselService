// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Show
import struct Schemata.Projection
import protocol Identity.Identifiable

struct ShowBaseFields {
	let id: Show.ID
	let name: String
}

// MARK: -
extension ShowBaseFields: ShowFields {
	// MARK: ModelProjection
	static let projection = Projection<Show.Identified, Self>(
		Self.init,
		\.id,
		\.value.name
	)
}
