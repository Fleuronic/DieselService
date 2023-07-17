// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Venue
import protocol Catena.Fields

protocol VenueFields: Fields where Model == Venue.Identified {}
