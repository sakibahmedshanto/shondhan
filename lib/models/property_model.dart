import 'custom_position_model.dart';

class Property {
  final String propertyId; // Unique identifier for the property
  final String buildingName; // Name of the building
  final double floor; // Floor number
  final double rentPrice; // Rent price
  final double sizeSqft; // Size in square feet
  final List<String> propertyImgs; // List of image URLs for the property
  final double bedroom; // Number of bedrooms
  final double diningSpace; // Dining space
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
    required this.propertyImgs, // Changed to list of images
    required this.bedroom,
    required this.diningSpace,
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
    required this.liked, // New liked field added
  });

  // Factory method for JSON serialization/deserialization
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['propertyId'], // JSON key is propertyId
      buildingName: json['buildingName'], // JSON key is buildingName
      floor: json['floor'], // JSON key is floor
      rentPrice: json['rentPrice'], // JSON key is rentPrice
      sizeSqft: json['sizeSqft'], // JSON key is sizeSqft
      propertyImgs: List<String>.from(json['propertyImgs']), // Changed to list of images
      bedroom: json['bedroom'], // JSON key is bedroom
      diningSpace: json['diningSpace'], // JSON key is diningSpace
      veranda: json['veranda'], // JSON key is veranda
      washroom: json['washroom'], // JSON key is washroom
      isAvailable: json['isAvailable'], // JSON key is isAvailable
      furnished: json['furnished'], // JSON key is furnished
      parkingSpace: json['parkingSpace'], // JSON key is parkingSpace
      propertyType: json['propertyType'], // JSON key is propertyType
      depositAmount: json['depositAmount'], // JSON key is depositAmount
      leaseTerm: json['leaseTerm'], // JSON key is leaseTerm
      utilitiesIncluded: List<String>.from(json['utilitiesIncluded']), // JSON key is utilitiesIncluded
      petFriendly: json['petFriendly'], // JSON key is petFriendly
      location: CustomPosition.fromJson(json['location']), // JSON key is location
      address: json['address'], // JSON key is address
      neighborhood: json['neighborhood'], // JSON key is neighborhood
      createdAt: DateTime.parse(json['createdAt']), // JSON key is createdAt
      updatedAt: DateTime.parse(json['updatedAt']), // JSON key is updatedAt
      description: json['description'], // JSON key is description
      nearbyFacilities: List<String>.from(json['nearbyFacilities']), // JSON key is nearbyFacilities
      ownerId: json['ownerId'], // JSON key is ownerId
      liked: json['liked'], // JSON key for liked status
    );
  }

  // Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId, // Property ID
      'buildingName': buildingName, // Building name
      'floor': floor, // Floor number
      'rentPrice': rentPrice, // Rent price
      'sizeSqft': sizeSqft, // Size in square feet
      'propertyImgs': propertyImgs, // Changed to list of image URLs
      'bedroom': bedroom, // Number of bedrooms
      'diningSpace': diningSpace, // Dining space
      'veranda': veranda, // Veranda space
      'washroom': washroom, // Number of washrooms
      'isAvailable': isAvailable, // Availability status
      'furnished': furnished, // Furnished status
      'parkingSpace': parkingSpace, // Parking space availability
      'propertyType': propertyType, // Type of property
      'depositAmount': depositAmount, // Deposit amount
      'leaseTerm': leaseTerm, // Lease term
      'utilitiesIncluded': utilitiesIncluded, // List of included utilities
      'petFriendly': petFriendly, // Pet-friendly status
      'location': location.toJson(), // Location as JSON
      'address': address, // Address of the property
      'neighborhood': neighborhood, // Neighborhood of the property
      'createdAt': createdAt.toIso8601String(), // Creation timestamp
      'updatedAt': updatedAt.toIso8601String(), // Update timestamp
      'description': description, // Description of the property
      'nearbyFacilities': nearbyFacilities, // List of nearby facilities
      'ownerId': ownerId, // Owner's UID
      'liked': liked, // Liked status
    };
  }
}
