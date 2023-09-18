// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Corps
import struct Diesel.Division
import struct Diesel.Feature
import struct Diesel.Location
import struct Diesel.Performance
import struct Diesel.Placement
import struct Diesel.Slot
import struct Foundation.TimeInterval
import protocol Identity.Identifiable
import struct Schemata.Projection

public struct SlotListFields {
	public let id: Slot.ID
	public let time: TimeInterval?
	public let featureName: String?
	public let featuredCorpsName: String?
	public let performingCorpsName: String?
	public let performingCorpsCity: String?
	public let performingCorpsState: String?
	public let performancePlacementRank: Int?
	public let performancePlacementScore: Double?
	public let performancePlacementDivisionName: String?
}

// MARK: -
extension SlotListFields: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Model.CodingKeys.self)
		id = try container.decode(Slot.ID.self, forKey: .id)
		time = try container.decodeIfPresent(TimeInterval.self, forKey: .time)

		let featureContainer = try? container.nestedContainer(keyedBy: Feature.CodingKeys.self, forKey: .feature)
		featureName = try featureContainer?.decode(String.self, forKey: .name)

		let featuredCorpsContainer = try? featureContainer?.nestedContainer(keyedBy: Corps.CodingKeys.self, forKey: .corps)
		featuredCorpsName = try featuredCorpsContainer?.decode(String.self, forKey: .name)

		let performanceContainer = try? container.nestedContainer(keyedBy: Performance.CodingKeys.self, forKey: .performance)
		let performingCorpsContainer = try performanceContainer?.nestedContainer(keyedBy: Corps.CodingKeys.self, forKey: .corps)
		performingCorpsName = try performingCorpsContainer?.decode(String.self, forKey: .name)

		let performingCorpsLocationContainer = try performingCorpsContainer?.nestedContainer(keyedBy: Location.CodingKeys.self, forKey: .location)
		performingCorpsCity = try performingCorpsLocationContainer?.decode(String.self, forKey: .city)
		performingCorpsState = try performingCorpsLocationContainer?.decode(String.self, forKey: .state)

		let performancePlacementContainer = try? performanceContainer?.nestedContainer(keyedBy: Placement.CodingKeys.self, forKey: .placement)
		performancePlacementRank = try performancePlacementContainer?.decode(Int.self, forKey: .rank)
		performancePlacementScore = try performancePlacementContainer?.decode(Double.self, forKey: .score)

		let divisionContainer = try performancePlacementContainer?.nestedContainer(keyedBy: Division.CodingKeys.self, forKey: .division)
		performancePlacementDivisionName = try divisionContainer?.decode(String.self, forKey: .name)
	}
}

// MARK: -
extension SlotListFields: SlotFields {
	// MARK: ModelProjection
	public static let projection = Projection<Slot.Identified, Self>(
		Self.init,
		\.id,
		\.value.time,
		\.feature.value.name,
		\.feature.corps.value.name,
		\.performance.corps.value.name,
		\.performance.corps.location.value.city,
		\.performance.corps.location.value.state,
		\.performance.placement.value.rank,
		\.performance.placement.value.score,
		\.performance.placement.division.value.name
	)
}

// MARK: -
private extension Feature {
	enum CodingKeys: String, CodingKey {
		case name
		case corps
	}
}

// MARK: -
private extension Performance {
	enum CodingKeys: String, CodingKey {
		case corps
		case placement
	}
}

// MARK: -
private extension Corps {
	enum CodingKeys: String, CodingKey {
		case name
		case location
	}
}

// MARK: -
private extension Location {
	enum CodingKeys: String, CodingKey {
		case city
		case state
	}
}

// MARK: -
private extension Placement {
	enum CodingKeys: String, CodingKey {
		case rank
		case score
		case division
	}
}

// MARK: -
private extension Division {
	enum CodingKeys: String, CodingKey {
		case name
	}
}
