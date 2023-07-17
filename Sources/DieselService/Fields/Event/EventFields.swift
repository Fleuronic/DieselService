// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event
import protocol Catena.Fields

protocol EventFields: Fields where Model == Event.Identified {}
