// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Schemata

import struct Diesel.Address
import struct Diesel.Corps
import struct Diesel.Event
import struct Diesel.Feature
import struct Diesel.Location
import struct Diesel.Performance
import struct Diesel.Slot
import struct Diesel.Venue
import struct Foundation.Date
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedSlot {
	public let id: Self.ID
	public let value: Slot
	public let event: Event.Identified
	public let feature: Feature.Identified!
	public let performance: Performance.Identified!
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
		events.compactMap(\.value.slug).contains(\.event.value.slug)
	}
}

// MARK: -
extension Slot.Identified: Catena.Model {
	public typealias RawIdentifier = UUID
	
	// MARK: Model
	public static let schema = Schema(
		Self.init..."slots",
		\.id * "id",
		\.value.time * "time",
		\.event --> "event",
		\.feature -->? "feature",
		\.performance -->? "performance"
	)

	public var valueSet: ValueSet<Self> {
		[
			\.value.time == value.time,
			\.event.id == event.id,
			\.performance.id == performance?.id,
			\.feature.id == feature?.id
		]
	}

	public static var relationships: Relationships {
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
		time: Date?,
		event: Event.Identified,
		feature: Feature.Identified?,
		performance: Performance.Identified?
	) {
		self.id = id
		self.event = event
		self.feature = feature
		self.performance = performance
		
		value = .init(time: time)
	}
}

// MARK: -
public extension [Slot] {
	var time: [Date?] { map(\.time) }
}

// MARK: -
public extension [Slot.Identified] {
	var id: [Slot.ID] { map(\.id) }
	var value: [Slot] { map(\.value) }
	var performance: [Performance.Identified] { map(\.performance) }
	var feature: [Feature.Identified] { map(\.feature) }
}
