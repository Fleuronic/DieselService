// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Show
import struct Diesel.Venue
import struct Foundation.Date
import struct Catena.IDFields
import struct Schemata.Projection

public struct EventBaseFields {
	public let id: Event.ID
	public let show: IDFields<Show.Identified>?
	public let location: IDFields<Location.Identified>
	public let venue: IDFields<Venue.Identified>?

	let slug: String?
	let date: Date
	let startTime: Date?
	let timeZone: String?
}

// MARK: -
extension EventBaseFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.show.id,
		\.location.id,
		\.venue.id,
		\.value.slug,
		\.value.date,
		\.value.startTime,
		\.value.timeZone
	)
}

// MARK: -
private extension EventBaseFields {
	init(
		id: Event.ID,
		showID: Show.ID?,
		locationID: Location.ID,
		venueID: Venue.ID?,
		slug: String?,
		date: Date,
		startTime: Date?,
		timeZone: String?
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
