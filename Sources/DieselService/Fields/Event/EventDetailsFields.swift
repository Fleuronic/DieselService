// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import struct Diesel.Venue
import struct Diesel.Address
import struct Diesel.Location
import struct Foundation.Date
import struct Foundation.Calendar
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct EventDetailsFields {
	public let id: Event.ID
	public let date: Date
	public let timeZone: String
	public let name: String?
	public let city: String
	public let state: String
	public let venueName: String?
	public let venueStreetAddress: String?
	public let venueZIPCode: String?
}

// MARK: -
extension EventDetailsFields: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Model.CodingKeys.self)
		id = try container.decode(Event.ID.self, forKey: .id)
		date = try container.decode(Date.self, forKey: .date)
		timeZone = try container.decode(String.self, forKey: .timeZone)
		name = try container.decodeIfPresent(String.self, forKey: .name)

		let locationContainer = try container.nestedContainer(keyedBy: Location.CodingKeys.self, forKey: .location)
		city = try locationContainer.decode(String.self, forKey: .city)
		state = try locationContainer.decode(String.self, forKey: .state)

		let venueContainer = try? container.nestedContainer(keyedBy: Venue.CodingKeys.self, forKey: .venue)
		venueName = try venueContainer?.decode(String.self, forKey: .name)

		let addressContainer = try venueContainer?.nestedContainer(keyedBy: Address.CodingKeys.self, forKey: .address)
		venueStreetAddress = try addressContainer?.decode(String.self, forKey: .streetAddress)
		venueZIPCode = try addressContainer?.decode(String.self, forKey: .zipCode)
	}
}

extension EventDetailsFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.value.date,
		\.value.timeZone,
		\.value.name,
		\.location.value.city,
		\.location.value.state,
		\.venue.value.name,
		\.venue.address.value.streetAddress,
		\.venue.address.value.zipCode
	)
}

// MARK: -
private extension Location {
	enum CodingKeys: String, CodingKey {
		case city
		case state
	}
}

// MARK: -
private extension Venue {
	enum CodingKeys: String, CodingKey {
		case name
		case address
	}
}

// MARK: -
private extension Address {
	enum CodingKeys: String, CodingKey {
		case streetAddress
		case zipCode
	}
}
