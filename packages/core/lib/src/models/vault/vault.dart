/// Immutable representation of a vault, including metadata and arbitrary data.
class Vault {
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  final Map<String, dynamic> data;

  /// Builds a [Vault] instance.
  ///
  /// @param name Display name of the vault.
  ///
  /// @param createdAt UTC timestamp when the vault was created.
  ///
  /// @param updatedAt UTC timestamp when the vault was last updated.
  ///
  /// @param data Arbitrary structured data stored inside the vault.
  const Vault({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
  });

  /// Returns a new [Vault] with updated fields while keeping unspecified values.
  ///
  /// @param name Optional replacement for the vault name.
  ///
  /// @param updatedAt Optional replacement for the update timestamp.
  ///
  /// @param data Optional replacement for the stored data payload.
  ///
  /// @returns A cloned vault with the provided overrides applied.
  Vault copyWith({
    String? name,
    DateTime? updatedAt,
    Map<String, dynamic>? data,
  }) {
    return Vault(
      name: name ?? this.name,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      data: data ?? this.data,
    );
  }

  /// Serializes this vault to a JSON-friendly structure.
  ///
  /// @returns A JSON map suitable for persistence.
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "data": data,
    };
  }

  /// Reconstructs a vault from a JSON map.
  ///
  /// @param json The map produced by [toJson].
  ///
  /// @returns The parsed [Vault] instance.
  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault(
      name: json["name"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
      data: (json["data"] as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// Creates a brand-new empty vault initialized with the current time.
  ///
  /// @param name The display name for the new vault.
  ///
  /// @returns A new [Vault] with empty data and matching creation/update times.
  static Vault createNew(String name) {
    final DateTime now = DateTime.now().toUtc();
    return Vault(
      name: name,
      createdAt: now,
      updatedAt: now,
      data: <String, dynamic>{},
    );
  }
}
