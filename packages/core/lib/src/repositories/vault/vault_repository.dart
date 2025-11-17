import "dart:io";

import "package:core/src/models/vault/vault.dart";

abstract class VaultRepository {
  /// Loads a vault from the given file.
  ///
  /// @param file - The file to load the vault from.
  ///
  /// @returns a [Future] vault representing the loaded data.
  Future<Vault> loadFromFile(File file);

  /// Persists the provided vault into file.
  ///
  /// @param [Vault] vault - The in-memory vault to serialize.
  ///
  /// @param [File] file - The destination file.
  ///
  /// @returns a [Future] void that completes when the data is fully written.
  Future<void> saveToFile(Vault vault, File file);

  /// Creates a brand-new file representing the vault.
  ///
  /// @param [Vault] vault - The vault instance to persist.
  ///
  /// @param [File] file - The file that should be created or overwritten.
  ///
  /// @returns a [Future] file containing the resulting file once creation finishes.
  Future<File> createNewFile(Vault vault, File file);
}
