// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata
import PersistDB

import struct Diesel.Event
import struct Diesel.Venue
import struct Diesel.Address
import struct Diesel.Location
import struct Diesel.Slot
import struct Diesel.Feature
import struct Diesel.Corps
import struct Diesel.Performance
import struct Foundation.UUID
import struct Foundation.TimeInterval
import protocol Catena.Model

public struct IdentifiedSlot {
	public let id: Self.ID

	let value: Slot
	let event: Event.Identified
	let feature: Feature.Identified!
	let performance: Performance.Identified!
}

// MARK: -
public extension Slot {
	typealias ID = Identified.ID
	typealias Identified = IdentifiedSlot

	func identified(
		id: ID? = nil,
		event: Event.Identified,
		feature: Feature.Identified? = nil,
		performance: Performance.Identified? = nil
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			event: event,
			feature: feature,
			performance: performance
		)
	}

	static func isPartOfEvent(with id: Event.ID) -> Predicate<Identified> {
		\.event.id == id
	}

	static func isPartOfEvent(from events: [Event.Identified]) -> Predicate<Identified> {
		events.map(\.value.name).contains(\.event.value.name)
	}
}

// MARK: -
extension Slot.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case time
		case feature
		case performance
	}
}

// MARK: -
extension Slot.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Slot.Identified: Catena.Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "slots",
		\.id ~ "id",
		\.value.time ~ "time",
		\.event ~ "event",
		\.feature ~? "feature",
		\.performance ~? "performance"
	)
	
	public var valueSet: ValueSet<Self> {
        [
			\.value.time == value.time,
			\.event.id == event.id,
            \.performance.id == performance?.id,
            \.feature.id == feature?.id
		]
	}
	
	public static var foreignKeys: ForeignKeys {
		[
			\.event.id: \.event,
			\.feature.id: \.feature!,
			\.performance.id: \.performance!
		]
	}
}

// MARK: -
private extension Slot.Identified {
	init(
		id: ID,
		time: TimeInterval?,
		event: Event.Identified,
		feature: Feature.Identified?,
		performance: Performance.Identified?
	) {
		self.id = id
		self.event = event
		self.feature = feature
		self.performance = performance

		value = .init(
			time: time
		)
	}
}
// MARK: -
extension [Slot] {
	var time: [TimeInterval?] { map(\.time) }
}

// MARK: -
extension [Slot.Identified] {
	var id: [Slot.ID] { map(\.id) }
	var value: [Slot] { map(\.value) }
	var performance: [Performance.Identified] { map(\.performance) }
	var feature: [Feature.Identified] { map(\.feature) }
}
