/// Equipment taxonomy for a captured asset.
///
/// Separate from `ShopCategory`, which describes what a shop *sells*. An
/// asset category decides which catalog the item routes into, so it is
/// modelled independently even where the two vocabularies overlap.
enum AssetCategory {
  generators,
  waterPumps,
  welding,
  buildingMaterials,
  electrical,
  sound,
  lighting,
  compression,
  catering,
  beverages,
  fertilizer,
}
