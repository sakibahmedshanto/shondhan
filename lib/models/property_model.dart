import 'custom_position_model.dart';

class Property {
  final String flatId;
  final String buildingName;
  final double floor;
  final double rentPrice;
  final double sizeSqft;
  final String flatImg;
  final double bedroom;
  final double diningSpace;
  final double veranda;
  final double washroom;
  final bool isAvailable;
  final bool furnished;
  final bool parkingSpace;
  final String propertyType;
  final double depositAmount;
  final String leaseTerm;
  final List<String> utilitiesIncluded;
  final bool petFriendly;
  final CustomPosition location;  // Using CustomPosition for location
  final String address;
  final String neighborhood;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final List<String> nearbyFacilities;
  final String ownerId;  // New ownerId field

  Property({
    required this.flatId,
    required this.buildingName,
    required this.floor,
    required this.rentPrice,
    required this.sizeSqft,
    required this.flatImg,
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
    required this.location,  // CustomPosition
    required this.address,
    required this.neighborhood,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.nearbyFacilities,
    required this.ownerId,  // New ownerId
  });

  // Factory method for JSON serialization/deserialization
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      flatId: json['flat_id'],
      buildingName: json['building_name'],
      floor: json['floor'].toDouble(),
      rentPrice: json['rent_price'].toDouble(),
      sizeSqft: json['size_sqft'].toDouble(),
      flatImg: json['flat_img'],
      bedroom: json['bedroom'].toDouble(),
      diningSpace: json['dinning_space'].toDouble(),
      veranda: json['veranda'].toDouble(),
      washroom: json['washroom'].toDouble(),
      isAvailable: json['isAvailable'],
      furnished: json['furnished'],
      parkingSpace: json['parking_space'],
      propertyType: json['property_type'],
      depositAmount: json['deposit_amount'].toDouble(),
      leaseTerm: json['lease_term'],
      utilitiesIncluded: List<String>.from(json['utilities_included']),
      petFriendly: json['pet_friendly'],
      location: CustomPosition.fromJson(json['location']),  // Deserialize location
      address: json['address'],
      neighborhood: json['neighborhood'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      description: json['description'],
      nearbyFacilities: List<String>.from(json['Nearby_facilities']),
      ownerId: json['owner_id'],  // Deserialize ownerId
    );
  }

  // Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'flat_id': flatId,
      'building_name': buildingName,
      'floor': floor,
      'rent_price': rentPrice,
      'size_sqft': sizeSqft,
      'flat_img': flatImg,
      'bedroom': bedroom,
      'dinning_space': diningSpace,
      'veranda': veranda,
      'washroom': washroom,
      'isAvailable': isAvailable,
      'furnished': furnished,
      'parking_space': parkingSpace,
      'property_type': propertyType,
      'deposit_amount': depositAmount,
      'lease_term': leaseTerm,
      'utilities_included': utilitiesIncluded,
      'pet_friendly': petFriendly,
      'location': location.toJson(),  // Serialize location
      'address': address,
      'neighborhood': neighborhood,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'Nearby_facilities': nearbyFacilities,
      'owner_id': ownerId,  // Serialize ownerId
    };
  }
}
