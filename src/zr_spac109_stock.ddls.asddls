@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock data model'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC109_STOCK as select from zspac109_stock

  association [0..1] to zspac109_product as _Product
  on $projection.ProductId = _Product.product_id

  association [0..1] to zspac109_wh as _Warehouse
  on $projection.WarehouseId = _Warehouse.warehouse_id
  
{
  key warehouse_id as WarehouseId,
  key product_id as ProductId,
  amount as Amount,
  
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at  as LastChangedAt,
  
  _Product.product_name        as ProductName,
  _Product.product_description as ProductDescription,
  _Product.category            as ProductCategory,

  _Warehouse.warehouse_name    as WarehouseName,
  _Warehouse.address           as WarehouseAddress,
  _Warehouse.city              as WarehouseCity,
  _Warehouse.postal_code       as PostalCode,

  _Product,
  _Warehouse
}
