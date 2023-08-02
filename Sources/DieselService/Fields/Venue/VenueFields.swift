// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Venue
import protocol Catena.Fields
import protocol Schemata.ModelProjection

public protocol VenueFields: Fields where Model == Venue.Identified {}
