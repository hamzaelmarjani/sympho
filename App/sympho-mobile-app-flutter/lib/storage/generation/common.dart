import 'package:flutter/cupertino.dart';
import 'package:sympho/storage/keys.dart';
import 'package:sympho/storage/secure.dart';

class GenerationIdManager {
  static const String _generationsKey = "generations";

  /// Retrieves the current list of generation IDs from secure storage
  static Future<List<String>> _getGenerationIds() async {
    try {
      final storedData = await SecureStorageCrud().read<Map<String, dynamic>>(
        StorageKeys.generationIds,
      );

      if (storedData == null || !storedData.containsKey(_generationsKey)) {
        return <String>[];
      }

      final generations = storedData[_generationsKey];
      if (generations is! List) {
        return <String>[];
      }

      return generations
          .where((item) => item != null)
          .map((item) => item.toString())
          .toList();
    } catch (e) {
      debugPrint('Error reading generation IDs: $e');
      return <String>[];
    }
  }

  /// Saves the list of generation IDs to secure storage
  static Future<bool> _saveGenerationIds(List<String> ids) async {
    try {
      await SecureStorageCrud().write(StorageKeys.generationIds, {
        _generationsKey: ids,
      });
      return true;
    } catch (e) {
      debugPrint('Error saving generation IDs: $e');
      return false;
    }
  }

  /// Adds a new generation ID to the stored list
  /// Returns true if successful, false otherwise
  static Future<bool> addGenerationId(String id) async {
    if (id.isEmpty) {
      return false;
    }

    final currentIds = await _getGenerationIds();

    if (!currentIds.contains(id)) {
      currentIds.add(id);
      return await _saveGenerationIds(currentIds);
    }

    return true;
  }

  /// Removes a generation ID from the stored list
  /// Returns true if successful, false otherwise
  static Future<bool> removeGenerationId(String id) async {
    if (id.isEmpty) {
      return false;
    }

    final currentIds = await _getGenerationIds();
    final initialLength = currentIds.length;

    currentIds.removeWhere((storedId) => storedId == id);

    if (currentIds.length != initialLength) {
      return await _saveGenerationIds(currentIds);
    }

    return true;
  }

  /// Gets all stored generation IDs
  /// Returns empty list if none found or on error
  static Future<List<String>> getAllGenerationIds() async {
    return await _getGenerationIds();
  }

  /// Removes all generation IDs
  /// Returns true if successful, false otherwise
  static Future<bool> clearAllGenerationIds() async {
    return await _saveGenerationIds(<String>[]);
  }

  /// Adds multiple generation IDs at once
  /// Returns true if successful, false otherwise
  static Future<bool> addMultipleGenerationIds(List<String> ids) async {
    if (ids.isEmpty) {
      return true;
    }

    final validIds = ids.where((id) => id.isNotEmpty).toList();
    if (validIds.isEmpty) {
      return false;
    }

    final currentIds = await _getGenerationIds();
    final currentIdsSet = currentIds.toSet();

    final newIds = validIds.where((id) => !currentIdsSet.contains(id)).toList();

    if (newIds.isNotEmpty) {
      currentIds.addAll(newIds);
      return await _saveGenerationIds(currentIds);
    }

    return true;
  }

  /// Checks if a generation ID exists in storage
  static Future<bool> containsGenerationId(String id) async {
    if (id.isEmpty) {
      return false;
    }

    final currentIds = await _getGenerationIds();
    return currentIds.contains(id);
  }
}
