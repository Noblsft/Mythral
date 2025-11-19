import "dart:io";

import "package:file_selector/file_selector.dart";
import "package:flutter/foundation.dart";

import "../../models/vault/vault.dart";
import "../../repositories/vault/vault_repository.dart";

enum StartScreenStatus { idle, loading, error }

class StartScreenViewModel extends ChangeNotifier {
  final VaultRepository vaultRepository;

  StartScreenStatus status = StartScreenStatus.idle;
  String? errorMessage;

  StartScreenViewModel({required this.vaultRepository});

  /// Creates a new vault file after prompting the user for a save location.
  ///
  /// @Returns the created [Vault], or [null] if the user cancels the dialog or
  /// a failure occurs.
  Future<Vault?> createVault() async {
    try {
      final File? targetFile = await _promptForSaveLocation();
      if (targetFile == null) {
        debugPrint("User cancelled save dialog");
        return null;
      }

      final String vaultName = targetFile.uri.pathSegments.last.replaceAll(
        ".mythral",
        "",
      );

      status = StartScreenStatus.loading;
      errorMessage = null;
      notifyListeners();

      final Vault vault = Vault.createNew(vaultName);
      await vaultRepository.createNewFile(vault, targetFile);

      status = StartScreenStatus.idle;
      notifyListeners();
      return vault;
    } catch (error, stackTrace) {
      debugPrint("Error creating vault: $error\n$stackTrace");
      status = StartScreenStatus.error;
      errorMessage = "Failed to create vault";
      notifyListeners();
      return null;
    }
  }

  /// Loads an existing vault file, optionally using the provided [file] path.
  ///
  /// @Returns the opened [Vault], or [null] if the user cancels the dialog or a
  /// failure occurs.
  Future<Vault?> openVault([File? file]) async {
    try {
      final File? targetFile = file ?? await _promptForExistingFile();
      if (targetFile == null) {
        debugPrint("User cancelled open dialog");
        return null;
      }

      status = StartScreenStatus.loading;
      errorMessage = null;
      notifyListeners();

      final Vault vault = await vaultRepository.loadFromFile(targetFile);

      status = StartScreenStatus.idle;
      notifyListeners();
      return vault;
    } catch (error, stackTrace) {
      debugPrint("Error opening vault: $error\n$stackTrace");
      status = StartScreenStatus.error;
      errorMessage = "Failed to open vault";
      notifyListeners();
      return null;
    }
  }

  /// Clears the current error state and notifies listeners when applicable.
  void resetError() {
    if (status == StartScreenStatus.error) {
      status = StartScreenStatus.idle;
      errorMessage = null;
      notifyListeners();
    }
  }

  Future<File?> _promptForSaveLocation() async {
    final FileSaveLocation? saveLocation = await getSaveLocation(
      suggestedName: "MyVault.mythral",
      confirmButtonText: "Create",
    );

    if (saveLocation == null) {
      return null;
    }

    return File(saveLocation.path);
  }

  Future<File?> _promptForExistingFile() async {
    final XFile? selectedFile = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(label: "Mythral Vault", extensions: <String>["mythral"]),
      ],
    );

    if (selectedFile == null) {
      return null;
    }

    return File(selectedFile.path);
  }
}
