// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Show
import struct Diesel.Venue
import struct Foundation.Date
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct EventBaseFields {
	public let id: Event.ID

	let show: IDFields<Show.Identified>?
	let slug: String?
	let date: Date
	let startTime: Date?
	let timeZone: String?
	let location: IDFields<Location.Identified>
	let venue: IDFields<Venue.Identified>?
}

// MARK: -
extension EventBaseFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.show.id,
		\.value.slug,
		\.value.date,
		\.value.startTime,
		\.value.timeZone,
		\.location.id,
		\.venue.id
	)
}

// MARK: -
private extension EventBaseFields {
	init(
		id: Event.ID,
		showID: Show.ID?,
		slug: String?,
		date: Date,
		startTime: Date?,
		timeZone: String?,
		locationID: Location.ID,
		venueID: Venue.ID?
	) {
		self.id = id
		self.slug = slug
		self.date = date
		self.startTime = startTime
		self.timeZone = timeZone

		show = showID.map { .init(id: $0) }
		location = .init(id: locationID)
		venue = venueID.map { .init(id: $0) }
	}
}
