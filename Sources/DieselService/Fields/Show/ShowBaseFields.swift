// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Show
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct ShowBaseFields {
	public let id: Show.ID
	public let name: String

	public init(
		id: Show.ID,
		name: String
	) {
		self.id = id
		self.name = name
	}
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
