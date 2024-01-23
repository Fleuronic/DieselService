// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Show
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct ShowBaseFields {
	public let id: Show.ID
	public let name: String
}

// MARK: -
extension ShowBaseFields: ShowFields {
	// MARK: ModelProjection
	public static let projection = Projection<Show.Identified, Self>(
		Self.init,
		\.id,
		\.value.name
	)
}
