// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Placement
import struct Diesel.Division
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct PlacementBaseFields {
	public let id: Placement.ID
	public let rank: Int
	public let score: Double
	public let division: IDFields<Division.Identified>
}

extension PlacementBaseFields: PlacementFields {
	// MARK: ModelProjection
	public static let projection = Projection<Placement.Identified, Self>(
		Self.init,
		\.id,
		\.value.rank,
		\.value.score,
		\.division.id
	)
}

// MARK: -
private extension PlacementBaseFields {
	init(
		id: Placement.ID,
		rank: Int,
		score: Double,
		divisionID: Division.ID
	) {
		self.id = id
		self.rank = rank
		self.score = score
		
		division = .init(id: divisionID)
	}
}
