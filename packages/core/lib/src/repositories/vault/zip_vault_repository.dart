import "dart:convert";
import "dart:io";

import "package:archive/archive.dart";
import "package:core/src/models/vault/vault.dart";

import "vault_repository.dart";

/// [VaultRepository] implementation that stores vault data inside a ZIP archive.
class ZipVaultRepository implements VaultRepository {
  static const String jsonEntryName = "vault.json";
  static const String attachmentsFolderName = "attachments/";

  @override
  /// Loads a vault from a ZIP file containing a `vault.json` entry.
  ///
  /// @param file The ZIP archive to read from.
  ///
  /// @returns The deserialized [Vault].
  Future<Vault> loadFromFile(File file) async {
    final List<int> bytes = await file.readAsBytes();

    final Archive archive = ZipDecoder().decodeBytes(bytes);

    final ArchiveFile? jsonEntry = archive.files
        .where((entry) => entry.name == jsonEntryName)
        .cast<ArchiveFile?>()
        .firstWhere((entry) => entry != null, orElse: () => null);

    if (jsonEntry == null) {
      throw FormatException(
        "Bundle does not contain $jsonEntryName: ${file.path}",
      );
    }

    final List<int> jsonBytes = jsonEntry.content as List<int>;
    final String jsonString = utf8.decode(jsonBytes);
    final Map<String, dynamic> jsonMap =
        jsonDecode(jsonString) as Map<String, dynamic>;

    return Vault.fromJson(jsonMap);
  }

  @override
  /// Saves a vault by encoding it as JSON inside a ZIP archive.
  ///
  /// @param vault The vault to persist.
  /// @param file The destination ZIP file.
  ///
  /// @returns Completes when the ZIP file is written to disk.
  Future<void> saveToFile(Vault vault, File file) async {
    final Archive archive = Archive();

    final String jsonString = const JsonEncoder.withIndent(
      "  ",
    ).convert(vault.toJson());
    final List<int> jsonBytes = utf8.encode(jsonString);

    archive.addFile(ArchiveFile(jsonEntryName, jsonBytes.length, jsonBytes));

    final List<int>? zipBytes = ZipEncoder().encode(archive);
    if (zipBytes == null) {
      throw StateError("Failed to encode vault archive");
    }

    await file.writeAsBytes(zipBytes, flush: true);
  }

  @override
  /// Creates a new vault archive using the ZIP format.
  ///
  /// @param vault The vault to persist.
  /// @param file The file path to write to.
  ///
  /// @returns The created ZIP file.
  Future<File> createNewFile(Vault vault, File file) async {
    await saveToFile(vault, file);
    return file;
  }
}
