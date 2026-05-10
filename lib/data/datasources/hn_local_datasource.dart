import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hn_reader/data/models/hn_item_model.dart';

/// Local data source using Hive to cache HN items.
///
/// Saves items as raw JSON strings to avoid needing complex Hive TypeAdapters
/// for polymorphic [HnItemModel] objects.
class HnLocalDataSource {
  static const String _boxName = 'hn_items_cache';
  static const String _idListBoxName = 'hn_ids_cache';

  Box<String>? _itemBox;
  Box<String>? _idBox;

  /// Must be called before using the data source.
  Future<void> init() async {
    _itemBox = await Hive.openBox<String>(_boxName);
    _idBox = await Hive.openBox<String>(_idListBoxName);
  }

  // ---------------------------------------------------------------------------
  // Item Caching (Stories & Comments)
  // ---------------------------------------------------------------------------

  /// Retrieves a cached item by [id].
  Future<HnItemModel?> getItem(int id) async {
    if (_itemBox == null) return null;
    final jsonString = _itemBox!.get(id.toString());
    if (jsonString == null) return null;

    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return HnItemModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  /// Saves an [item] to the cache.
  Future<void> saveItem(HnItemModel item) async {
    if (_itemBox == null) return;
    final jsonString = jsonEncode(item.toJson());
    await _itemBox!.put(item.id.toString(), jsonString);
  }

  // ---------------------------------------------------------------------------
  // Feed ID Caching
  // ---------------------------------------------------------------------------

  /// Retrieves a cached list of IDs for a specific [feedType] (e.g., "top").
  Future<List<int>?> getStoryIds(String feedType) async {
    if (_idBox == null) return null;
    final jsonString = _idBox!.get(feedType);
    if (jsonString == null) return null;

    try {
      final list = jsonDecode(jsonString) as List<dynamic>;
      return list.cast<int>();
    } catch (_) {
      return null;
    }
  }

  /// Saves a list of [ids] for a specific [feedType].
  Future<void> saveStoryIds(String feedType, List<int> ids) async {
    if (_idBox == null) return;
    final jsonString = jsonEncode(ids);
    await _idBox!.put(feedType, jsonString);
  }
}
