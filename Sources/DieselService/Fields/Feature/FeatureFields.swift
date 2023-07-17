// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Feature
import protocol Catena.Fields

protocol FeatureFields: Fields where Model == Feature.Identified {}
