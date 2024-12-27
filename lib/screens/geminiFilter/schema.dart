import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final schema = Schema.object(
  properties: {
    'propertyId': Schema.string(description: 'Unique identifier for the property.'),
    'buildingName': Schema.string(description: 'Name of the building.'),
    'floor': Schema.number(description: 'Floor number.'),
    'priceLower': Schema.number(description: 'Lower range of the property rent price if anyone says any specific price take 5k less than the specific price as lower price'),
    'priceUpper': Schema.number(description: 'Upper range of the property rent price if anyone says any specific price take 5k more than the specific price as upper price'),
    'sizeSqft': Schema.number(description: 'Size in square feet.'),
    'bedroom': Schema.number(description: 'Number of bedrooms.'),
    'diningSpace': Schema.number(description: 'Dining space.'),
    'livingRoom': Schema.number(description: 'Living room space.'),
    'kitchen': Schema.number(description: 'Kitchen space.'),
    'storeRoom': Schema.number(description: 'Store room space.'),
    'veranda': Schema.number(description: 'Veranda space.'),
    'washroom': Schema.number(description: 'Number of washrooms.'),
    'isAvailable': Schema.boolean(description: 'Availability status.'),
    'furnished': Schema.boolean(description: 'Furnished status.'),
    'parkingSpace': Schema.boolean(description: 'Parking space availability.'),
    'propertyType': Schema.string(description: 'Type of the property.'),
    'depositAmount': Schema.number(description: 'Deposit amount.'),
    'leaseTerm': Schema.string(description: 'Lease term.'),
    'petFriendly': Schema.boolean(description: 'Pet-friendly status.'),
    'location': Schema.object(
      properties: {
        'latitude': Schema.number(description: 'Latitude of the property.'),
        'longitude': Schema.number(description: 'Longitude of the property.'),
      },
    ),
    'neighborhood': Schema.string(description: 'Neighborhood of the property.'),
    'createdAt': Schema.string(description: 'Creation date of the property.'),
    'updatedAt': Schema.string(description: 'Last update date of the property.'),
    'description': Schema.string(description: 'Description of the property.'),
    'ownerId': Schema.string(description: 'Owner ID of the property.'),
    'liked': Schema.boolean(description: 'Liked status of the property.'),
  },
);

final model = GenerativeModel(
  model: 'gemini-1.5-pro',
  apiKey: "AIzaSyANplDFcQdepR8i4YB40H1PxLB_4jJSBS8",
  generationConfig: GenerationConfig(
    responseMimeType: 'application/json',
    responseSchema: schema,
  ),
);
