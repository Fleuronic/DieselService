// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import struct Diesel.Venue
import protocol Schemata.ModelProjection

public protocol VenueFields: Fields where Model == Venue.Identified {}
