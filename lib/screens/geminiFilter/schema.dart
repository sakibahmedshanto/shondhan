import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final schema = Schema.object(
  properties: {
    'bedroom': Schema.number(description: 'Number of bedrooms.'),
    'rentPrice': Schema.number(description: 'Rent price of the property.'),
    'floor': Schema.number(description: 'Floor number.'),
    'isAvailable': Schema.boolean(description: 'Availability of the property.'),
    'location': Schema.object(
      properties: {
        'latitude': Schema.number(description: 'Latitude of the property.'),
        'longitude': Schema.number(description: 'Longitude of the property.'),
      },
    ),
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
