class Owner {
  final String ownerId;        // Unique identifier for the owner
  final String name;           // Owner's name
  final String email;          // Owner's email
  final String phone;          // Owner's phone number
  final List<String> propertyIds;  // List of property IDs owned by the owner

  Owner({
    required this.ownerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.propertyIds,  // List of property IDs
  });

  // Factory method for JSON serialization/deserialization
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      ownerId: json['owner_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      propertyIds: List<String>.from(json['property_ids'] ?? []),  // Deserialize as a list
    );
  }

  // Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'owner_id': ownerId,
      'name': name,
      'email': email,
      'phone': phone,
      'property_ids': propertyIds,  // Serialize as a list
    };
  }
}
