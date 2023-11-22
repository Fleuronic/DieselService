// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Slot
import struct Foundation.Date
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct SlotBaseFields {
	public let id: Slot.ID
	public let time: Date?
}

// MARK: -
extension SlotBaseFields: SlotFields {
	// MARK: ModelProjection
	public static let projection = Projection<Slot.Identified, Self>(
		Self.init,
		\.id,
		\.value.time
	)
}
