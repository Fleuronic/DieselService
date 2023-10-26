// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Show
import struct Foundation.Calendar
import struct Foundation.Date
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct EventListFields {
	public let id: Event.ID
	public let date: Date
	public let showName: String?
	public let city: String
	public let state: String
}

// MARK: -
extension EventListFields: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Model.CodingKeys.self)
		id = try container.decode(Event.ID.self, forKey: .id)
		date = try container.decode(Date.self, forKey: .date)
		
		let showContainer = try? container.nestedContainer(keyedBy: Show.CodingKeys.self, forKey: .show)
		showName = try showContainer?.decode(String.self, forKey: .name)
		
		let locationContainer = try container.nestedContainer(keyedBy: Location.CodingKeys.self, forKey: .location)
		city = try locationContainer.decode(String.self, forKey: .city)
		state = try locationContainer.decode(String.self, forKey: .state)
	}
}

extension EventListFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.value.date,
		\.show.value.name,
		\.location.value.city,
		\.location.value.state
	)
}

// MARK: -
private extension Show {
	enum CodingKeys: String, CodingKey {
		case name
	}
}

// MARK: -
private extension Location {
	enum CodingKeys: String, CodingKey {
		case city
		case state
	}
}
