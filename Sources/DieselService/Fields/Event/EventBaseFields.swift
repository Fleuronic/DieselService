// Copyright © Fleuronic LLC. All rights reserved.

import enum Catenary.IDCodingKeys
import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Show
import struct Diesel.Venue
import struct Foundation.Date
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct EventBaseFields {
	public let id: Event.ID
	public let showID: Show.ID?
	public let slug: String?
	public let date: Date
	public let timeZone: String?
	public let locationID: Location.ID
	public let venueID: Venue.ID?
}

// MARK: -
extension EventBaseFields: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Model.CodingKeys.self)
		id = try container.decode(Event.ID.self, forKey: .id)
		slug = try container.decodeIfPresent(String.self, forKey: .slug)
		date = try container.decode(Date.self, forKey: .date)
		timeZone = try container.decode(String.self, forKey: .timeZone)
		
		let showContainer = try? container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .show)
		showID = try showContainer?.decode(Show.ID.self, forKey: .id)
		
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
		\.show?.id,
		\.value.slug,
		\.value.date,
		\.value.timeZone,
		\.location.id,
		\.venue?.id
	)
}
