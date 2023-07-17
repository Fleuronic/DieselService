// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Slot
import protocol Catena.Fields

protocol SlotFields: Fields where Model == Slot.Identified {}
