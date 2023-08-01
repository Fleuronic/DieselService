// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Venue
import struct Foundation.Date
import protocol Identity.Identifiable

public struct EventBaseFields {
	public let id: Event.ID
	public let name: String?
	public let slug: String?
	public let date: Date
	public let timeZone: String
	public let locationID: Location.ID
	public let venueID: Venue.ID?
}

// MARK: -
extension EventBaseFields: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Event.Identified.CodingKeys.self)
		id = try container.decode(Event.ID.self, forKey: .id)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		slug = try container.decodeIfPresent(String.self, forKey: .slug)
		date = try container.decode(Date.self, forKey: .date)
		timeZone = try container.decode(String.self, forKey: .timeZone)

		let locationContainer = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .location)
		locationID = try locationContainer.decode(Location.ID.self, forKey: .id)

		let venueContainer = try? container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .venue)
		venueID = try venueContainer?.decode(Venue.ID.self, forKey: .id)
	}
}

extension EventBaseFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.value.slug,
		\.value.date,
		\.value.timeZone,
		\.location.id,
		\.venue.id
	)
}
