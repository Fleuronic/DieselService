// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Venue
import struct Diesel.Address
import struct Diesel.Slot
import struct Foundation.UUID
import struct Foundation.Date
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedEvent {
	public let id: Self.ID
	public let value: Event
	public let location: Location.Identified
    public let venue: Venue.Identified!
	public let slots: [Slot.Identified]
}

// MARK: -
public extension Event {
    typealias ID = Identified.ID
	typealias Identified = IdentifiedEvent

	func identified(
		id: ID? = nil,
		location: Location.Identified,
		venue: Venue.Identified?
	) -> Identified {
        .init(
			id: id ?? .random,
			value: self,
			location: location,
            venue: venue,
			slots: []
		)
	}

	static func `is`(in events: [Identified]) -> Predicate<Identified> {
		events.compactMap(\.value.slug).contains(\.value.slug)
	}
}

// MARK: -
public extension Event.Identified {
	init(
		fields: EventBaseFields,
		location: Location.Identified,
		venue: Venue.Identified?
	) {
		self.init(
			id: fields.id,
			name: fields.name,
			slug: fields.slug,
			date: fields.date,
			timeZone: fields.timeZone,
			location: location,
			venue: venue,
			slots: []
		)
	}
}

// MARK: -
extension Event.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Event.Identified: Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ... "events",
		\.id * "id",
		\.value.name * "name",
		\.value.slug * "slug",
		\.value.date * "date",
		\.value.timeZone * "time_zone",
		\.location --> "location",
		\.venue -->? "venue",
		\.slots -->> \.event
	)

	public var valueSet: ValueSet<Self> {
        [
			\.value.name == value.name,
			\.value.slug == value.slug,
			\.value.date == value.date,
			\.value.timeZone == value.timeZone,
			\.location.id == location.id,
            \.venue.id == venue?.id
		]
	}

	public static var relationships: Relationships {
		[
			\.location.id: \.location,
            \.venue.id: \.venue!
		]
	}
    
    public static var defaultOrder: [Ordering<Self>] {
        [.init(\.value.date, ascending: true)]
    }
}

// MARK: -
private extension Event.Identified {
	init(
		id: ID,
		name: String?,
		slug: String?,
		date: Date,
		timeZone: String,
		location: Location.Identified,
		venue: Venue.Identified?,
		slots: [Slot.Identified]
	) {
		self.id = id
		self.location = location
		self.venue = venue
		self.slots = slots

		value = .init(
			name: name,
			slug: slug,
			date: date,
			timeZone: timeZone
		)
	}
}
