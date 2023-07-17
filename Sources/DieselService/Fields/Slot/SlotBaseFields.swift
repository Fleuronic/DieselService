// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Slot
import struct Foundation.TimeInterval
import protocol Identity.Identifiable

public struct SlotBaseFields {
	public let id: Slot.ID
	public let time: TimeInterval?
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
