// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Performance
import struct Diesel.Corps
import struct Diesel.Placement
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct PerformanceBaseFields {
	public let id: Performance.ID
	public let corps: IDFields<Corps.Identified>
	public let placement: IDFields<Placement.Identified>?
}

extension PerformanceBaseFields: PerformanceFields {
	// MARK: ModelProjection
	public static let projection = Projection<Performance.Identified, Self>(
		Self.init,
		\.id,
		\.corps.id,
		\.placement.id
	)
}

// MARK: -
private extension PerformanceBaseFields {
	init(
		id: Performance.ID,
		corpsID: Corps.ID,
		placementID: Placement.ID?
	) {
		self.id = id

		corps = .init(id: corpsID)
		placement = placementID.map { .init(id: $0) }
	}
}
