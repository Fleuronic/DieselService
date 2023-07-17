// Copyright © Fleuronic LLC. All rights reserved.

import Identity
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

public struct IdentifiedEvent {
	public let id: Self.ID

	let value: Event
	let location: Location.Identified
    let venue: Venue.Identified!
	let slots: [Slot.Identified]
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

	static func hasName(fromNamesOf events: [Identified]) -> Predicate<Identified> {
		events.map(\.value.name).contains(\.value.name)
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
			date: fields.date,
			timeZone: fields.timeZone,
			location: location,
			venue: venue,
			slots: []
		)
	}
}

// MARK: -
extension Event.Identified {
	enum CodingKeys: String, CodingKey {
		case id
		case date
		case timeZone
		case name
		case location
		case venue
		case slots
	}
}

// MARK: -
extension Event.Identified: Identifiable {
	public typealias RawIdentifier = UUID
}

extension Event.Identified: Model {
	// MARK: Model
	public static let schema = Schema(
		Self.init ~ "events",
		\.id ~ "id",
		\.value.name ~ "name",
		\.value.date ~ "date",
		\.value.timeZone ~ "time_zone",
		\.location ~ "location",
		\.venue ~ "venue",
		\.slots ~ \Slot.Identified.event
	)

	public var valueSet: ValueSet<Self> {
		let valueSet: ValueSet<Self> = [
			\.value.name == value.name,
			\.value.date == value.date,
			\.value.timeZone == value.timeZone,
			\.location.id == location.id
		]

		return venue.map {
			valueSet.update(with: [\.venue.id == $0.id])
		} ?? valueSet
	}

	public static var foreignKeys: ForeignKeys {
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
			date: date,
			timeZone: timeZone
		)
	}
}
