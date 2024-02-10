// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import struct Diesel.Address
import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Show
import struct Diesel.Slot
import struct Diesel.Venue
import struct Foundation.Date
import struct Foundation.DateComponents
import struct Foundation.Calendar
import struct Foundation.UUID
import protocol Catena.Model
import protocol Identity.Identifiable

public struct IdentifiedEvent {
	public let id: ID
	public let value: Event
	public let show: Show.Identified!
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
		show: Show.Identified?,
		location: Location.Identified,
		venue: Venue.Identified?
	) -> Identified {
		.init(
			id: id ?? .random,
			value: self,
			show: show,
			location: location,
			venue: venue,
			slots: []
		)
	}

	static func `is`(in events: [Identified]) -> Predicate<Identified> {
		events.compactMap(\.value.slug).contains(\.value.slug)
	}

	static func takesPlace(in year: Int) -> Predicate<Identified> {
		let calendar = Calendar.current
		let startOfYear = DateComponents(calendar: calendar, year: year).date!
		let endOfYear = calendar.date(byAdding: .year, value: 1, to: startOfYear)!
		return \.value.date > startOfYear && \.value.date < endOfYear
	}
}

// MARK: -
extension Event.Identified {
	init(
		fields: EventBaseFields,
		show: Show.Identified?,
		location: Location.Identified,
		venue: Venue.Identified?
	) {
		self.init(
			id: fields.id,
			slug: fields.slug,
			date: fields.date,
			startTime: fields.startTime,
			timeZone: fields.timeZone,
			show: show,
			location: location,
			venue: venue,
			slots: []
		)
	}
}

// MARK: -
extension Event.Identified: Model {
	// MARK: Identifiable
	public typealias RawIdentifier = UUID

	// MARK: Model
	public static let schema = Schema(
		Self.init..."events",
		\.id * "id",
		\.value.slug * "slug",
		\.value.date * "date",
		\.value.startTime * "start_time",
		\.value.timeZone * "time_zone",
		\.show -->? "show",
		\.location --> "location",
		\.venue -->? "venue",
		\.slots -->> \.event
	)
	
	// MARK: Model
	public static let relationships: Relationships = [
		\.show.id: \.show!,
		\.location.id: \.location,
		\.venue.id: \.venue!
	]
	
	public static let defaultOrder: [Ordering<Self>] = [
		.init(\.value.date, ascending: true)
	]

	// MARK: Model
	public var valueSet: ValueSet<Self> {
		[
			\.value.slug == value.slug,
			\.value.date == value.date,
			\.value.startTime == value.startTime,
			\.value.timeZone == value.timeZone,
			\.show.id == show?.id,
			\.location.id == location.id,
			\.venue.id == venue?.id
		]
	}
}

// MARK: -
private extension Event.Identified {
	init(
		id: ID,
		slug: String?,
		date: Date,
		startTime: Date?,
		timeZone: String?,
		show: Show.Identified?,
		location: Location.Identified,
		venue: Venue.Identified?,
		slots: [Slot.Identified]
	) {
		self.id = id
		self.show = show
		self.location = location
		self.venue = venue
		self.slots = slots
		
		value = .init(
			slug: slug,
			date: date,
			startTime: startTime,
			timeZone: timeZone
		)
	}
}
