// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Slot
import struct Diesel.Feature
import struct Diesel.Corps
import struct Diesel.Performance
import struct Diesel.Location
import struct Diesel.Placement
import struct Diesel.Division
import struct Catena.IDFields
import struct Foundation.TimeInterval
import protocol Identity.Identifiable

public struct SlotRelationshipFields {
	public let id: Slot.ID
	public let performance: IDFields<Performance.Identified>?
	public let placement: IDFields<Placement.Identified>?
}

// MARK: -
extension SlotRelationshipFields: SlotFields {
	// MARK: ModelProjection
	public static let projection = Projection<Slot.Identified, Self>(
		Self.init,
		\.id,
		\.performance.id,
		\.performance.placement.id
	)
}

// MARK: -
private extension SlotRelationshipFields {
	init(
		id: Slot.ID,
		performanceID: Performance.ID?,
		placementID: Placement.ID?
	) {
		self.id = id
		performance = performanceID.map(IDFields<Performance.Identified>.init)
		placement = placementID.map(IDFields<Placement.Identified>.init)
	}
}
