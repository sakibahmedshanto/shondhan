import 'custom_position_model.dart';

class Property {
  final String propertyId; // Unique identifier for the property
  final String buildingName; // Name of the building
  final double floor; // Floor number
  final double rentPrice; // Rent price
  final double sizeSqft; // Size in square feet
  final List<String> propertyImgs; // List of image URLs for the property
  final List<String> propertyVideos; // New field: List of video URLs
  final double bedroom; // Number of bedrooms
  final double diningSpace; // Dining space
  final double livingRoom; // New field: Living room space
  final double kitchen; // New field: Kitchen space
  final double storeRoom; // New field: Store room space
  final double veranda; // Veranda space
  final double washroom; // Number of washrooms
  final bool isAvailable; // Availability status
  final bool furnished; // Furnished status
  final bool parkingSpace; // Parking space availability
  final String propertyType; // Type of property
  final double depositAmount; // Deposit amount
  final String leaseTerm; // Lease term
  final List<String> utilitiesIncluded; // List of included utilities
  final bool petFriendly; // Pet-friendly status
  final CustomPosition location; // Custom position for location
  final String address; // Address of the property
  final String neighborhood; // Neighborhood of the property
  final DateTime createdAt; // Creation timestamp
  final DateTime updatedAt; // Update timestamp
  final String description; // Description of the property
  final List<String> nearbyFacilities; // List of nearby facilities
  final String ownerId; // Reference to the UserModel's uid
  final bool liked; // Boolean to track if the property is liked by the user

  Property({
    required this.propertyId,
    required this.buildingName,
    required this.floor,
    required this.rentPrice,
    required this.sizeSqft,
    required this.propertyImgs,
    required this.propertyVideos, // New field
    required this.bedroom,
    required this.diningSpace,
    required this.livingRoom, // New field
    required this.kitchen, // New field
    required this.storeRoom, // New field
    required this.veranda,
    required this.washroom,
    required this.isAvailable,
    required this.furnished,
    required this.parkingSpace,
    required this.propertyType,
    required this.depositAmount,
    required this.leaseTerm,
    required this.utilitiesIncluded,
    required this.petFriendly,
    required this.location,
    required this.address,
    required this.neighborhood,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.nearbyFacilities,
    required this.ownerId,
    required this.liked,
  });

  // Factory method for JSON serialization/deserialization
factory Property.fromJson(Map<String, dynamic> json) {
  return Property(
    propertyId: json['propertyId'] ?? '',
    buildingName: json['buildingName'] ?? '',
    floor: (json['floor'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    rentPrice: (json['rentPrice'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    sizeSqft: (json['sizeSqft'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    propertyImgs: List<String>.from(json['propertyImgs'] ?? []),
    propertyVideos: List<String>.from(json['propertyVideos'] ?? []),
    bedroom: (json['bedroom'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    diningSpace: (json['diningSpace'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    livingRoom: (json['livingRoom'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    kitchen: (json['kitchen'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    storeRoom: (json['storeRoom'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    veranda: (json['veranda'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    washroom: (json['washroom'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    isAvailable: json['isAvailable'] ?? false,
    furnished: json['furnished'] ?? false,
    parkingSpace: json['parkingSpace'] ?? false,
    propertyType: json['propertyType'] ?? '',
    depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    leaseTerm: json['leaseTerm'] ?? '',
    utilitiesIncluded: List<String>.from(json['utilitiesIncluded'] ?? []),
    petFriendly: json['petFriendly'] ?? false,
    location: CustomPosition.fromJson(json['location']),
    address: json['address'] ?? '',
    neighborhood: json['neighborhood'] ?? '',
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    description: json['description'] ?? '',
    nearbyFacilities: List<String>.from(json['nearbyFacilities'] ?? []),
    ownerId: json['ownerId'] ?? '',
    liked: json['liked'] ?? false,
  );
}

  // Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'buildingName': buildingName,
      'floor': floor,
      'rentPrice': rentPrice,
      'sizeSqft': sizeSqft,
      'propertyImgs': propertyImgs,
      'propertyVideos': propertyVideos, // New field
      'bedroom': bedroom,
      'diningSpace': diningSpace,
      'livingRoom': livingRoom, // New field
      'kitchen': kitchen, // New field
      'storeRoom': storeRoom, // New field
      'veranda': veranda,
      'washroom': washroom,
      'isAvailable': isAvailable,
      'furnished': furnished,
      'parkingSpace': parkingSpace,
      'propertyType': propertyType,
      'depositAmount': depositAmount,
      'leaseTerm': leaseTerm,
      'utilitiesIncluded': utilitiesIncluded,
      'petFriendly': petFriendly,
      'location': location.toJson(),
      'address': address,
      'neighborhood': neighborhood,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'nearbyFacilities': nearbyFacilities,
      'ownerId': ownerId,
      'liked': liked,
    };
  }
}
