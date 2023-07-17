// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Location
import protocol Catena.Fields

protocol LocationFields: Fields where Model == Location.Identified {}
