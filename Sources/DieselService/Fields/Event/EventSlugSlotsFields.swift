// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Event
import struct Diesel.Slot
import struct Foundation.Date
import struct Foundation.TimeInterval
import protocol Identity.Identifiable

public struct EventSlugSlotsFields {
	public let id: Event.ID
	public let date: Date
	public let slug: String?
	public let slots: [SlotTimeFields]
}

extension EventSlugSlotsFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.value.date,
		\.value.slug,
		\.slots.id,
		\.slots.value.time
	)

	public static var toManyKeys: [PartialKeyPath<Event.Identified>: [String]] {
		let keys: [PartialKeyPath<Event.Identified>: [ToManyKeys]] = [
			\.slots.id: [.id],
			\.slots.value.time: [.time]
		]

		return keys.mapValues {
			([.slots] + $0).map(\.rawValue)
		}
	}
}

// MARK: -
private extension EventSlugSlotsFields {
	enum ToManyKeys: String {
		case slots
		case id
		case time
	}

	init(
		id: Event.ID,
		date: Date,
		slug: String?,
		slotIDs: [Slot.ID],
		slotTimes: [TimeInterval?]
	) {
		self.id = id
		self.date = date
		self.slug = slug

		var slots: [SlotTimeFields] = []
		for (index, id) in slotIDs.enumerated() {
			slots.append(
				.init(
					id: id,
					time: slotTimes[index]
				)
			)
		}
		self.slots = slots
	}
}
