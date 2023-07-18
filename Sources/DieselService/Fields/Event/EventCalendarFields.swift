// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Event
import struct Diesel.Location
import struct Diesel.Slot
import struct Diesel.Performance
import struct Diesel.Corps
import struct Diesel.Feature
import struct Diesel.Venue
import struct Diesel.Address
import struct Diesel.Placement
import struct Diesel.Division
import struct Foundation.Date
import struct Foundation.Calendar
import struct Foundation.TimeInterval
import protocol Identity.Identifiable

public struct EventCalendarFields {
	public let id: Event.ID
	public let date: Date
	public let name: String?
	public let timeZone: String
    public let venue: VenueAllFields
    public let slots: [SlotCalendarFields]
}

extension EventCalendarFields: EventFields {
	// MARK: ModelProjection
	public static let projection = Projection<Event.Identified, Self>(
		Self.init,
		\.id,
		\.value.date,
		\.value.name,
		\.value.timeZone,
        \.venue.id,
        \.venue.value.name,
        \.venue.address.id,
        \.venue.address.value.streetAddress,
        \.venue.address.value.zipCode,
        \.venue.address.location.id,
        \.venue.address.location.value.city,
        \.venue.address.location.value.state,
		\.slots.id,
		\.slots.value.time,
		\.slots.performance.id,
		\.slots.performance.corps.id,
		\.slots.performance.corps.value.name,
		\.slots.performance.corps.location.id,
		\.slots.performance.corps.location.value.city,
		\.slots.performance.corps.location.value.state,
		\.slots.performance.placement.id,
		\.slots.performance.placement.value.rank,
		\.slots.performance.placement.value.score,
		\.slots.performance.placement.division.id,
		\.slots.performance.placement.division.value.name,
		\.slots.feature.id,
		\.slots.feature.value.name,
		\.slots.feature.corps.id,
		\.slots.feature.corps.value.name
	)

	public static var toManyKeys: [PartialKeyPath<Event.Identified>: [String]] {
		let keys: [PartialKeyPath<Event.Identified>: [ToManyKeys]] = [
			\.slots.id: [.id],
			\.slots.value.time: [.time],
			\.slots.performance.id: [.performance, .id],
			\.slots.performance.corps.id: [.performance, .corps, .id],
			\.slots.performance.corps.value.name: [.performance, .corps, .name],
			\.slots.performance.corps.location.id: [.performance, .corps, .location, .id],
			\.slots.performance.corps.location.value.city: [.performance, .corps, .location, .city],
			\.slots.performance.corps.location.value.state: [.performance, .corps, .location, .state],
			\.slots.performance.placement.id: [.performance, .placement, .id],
			\.slots.performance.placement.value.rank: [.performance, .placement, .rank],
			\.slots.performance.placement.value.score: [.performance, .placement, .score],
			\.slots.performance.placement.division.id: [.performance, .placement, .division, .id],
			\.slots.performance.placement.division.value.name: [.performance, .placement, .division, .name],
			\.slots.feature.id: [.feature, .id],
			\.slots.feature.value.name: [.feature, .name],
			\.slots.feature.corps.id: [.feature, .corps, .id],
			\.slots.feature.corps.value.name: [.feature, .corps, .name]
		]

		return keys.mapValues {
			([.slots] + $0).map(\.rawValue)
		}
	}
}

// MARK: -
private extension EventCalendarFields {
	enum ToManyKeys: String {
		case slots
		case id
		case time
		case performance
		case corps
		case name
		case location
		case city
		case state
		case placement
		case rank
		case score
		case division
		case feature
	}

	init(
		id: Event.ID,
		date: Date,
		name: String?,
		timeZone: String,
		venueID: Venue.ID,
		venueName: String,
		addressID: Address.ID,
		streetAddress: String,
		zipCode: String,
		locationID: Location.ID,
		city: String,
		state: String,
		slotIDs: [Slot.ID],
		slotTimes: [TimeInterval?],
		performanceIDs: [Performance.ID?],
		performingCorpsIDs: [Corps.ID],
		performingCorpsNames: [String],
		performingCorpsLocationIDs: [Location.ID],
		performingCorpsCities: [String],
		performingCorpsStates: [String],
		placementIDs: [Placement.ID?],
		ranks: [Int],
		scores: [Double],
		divisionIDs: [Division.ID],
		divisionNames: [String],
		featureIDs: [Feature.ID?],
		featureNames: [String],
		featuredCorpsIDs: [Corps.ID?],
		featuredCorpsNames: [String]
	) {
		self.id = id
		self.date = date
		self.name = name
		self.timeZone = timeZone

		venue = .init(
			id: venueID,
			name: venueName,
			address: .init(
				id: addressID,
				streetAddress: streetAddress,
				zipCode: zipCode,
				location: .init(
					id: locationID,
					city: city,
					state: state
				)
			)
		)

		var slots: [SlotCalendarFields] = []
		for (index, id) in slotIDs.enumerated() {
			slots.append(
				.init(
					id: id,
					time: slotTimes[index],
					performance: performanceIDs[index].map {
						.init(
							id: $0,
							corps: .init(
								id: performingCorpsIDs[index],
								name: performingCorpsNames[index],
								location: .init(
									id: performingCorpsLocationIDs[index],
									city: performingCorpsCities[index],
									state: performingCorpsStates[index]
								)
							),
							placement: placementIDs[index].map {
								.init(
									id: $0,
									rank: ranks[index],
									score: scores[index],
									division: .init(
										id: divisionIDs[index],
										name: divisionNames[index]
									)
								)
							}
						)
					}, feature: featureIDs[index].map {
						.init(
							id: $0,
							name: featureNames[index],
							corps: featuredCorpsIDs[index].map {
								.init(
									id: $0,
									name: featuredCorpsNames[index]
								)
							}
						)
					}
				)
			)
		}
		self.slots = slots
	}
}

// MARK: -
private extension Location {
	enum CodingKeys: String, CodingKey {
		case city, state
	}
}

// MARK: -
private extension Slot {
	enum CodingKeys: String, CodingKey {
		case performance
		case feature
	}
}

// MARK: -
private extension Performance {
	enum CodingKeys: String, CodingKey {
		case corps
	}
}

// MARK: -
private extension Corps {
	enum CodingKeys: String, CodingKey {
		case name
	}
}

// MARK: -
private extension Feature {
	enum CodingKeys: String, CodingKey {
		case name
		case corps
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
