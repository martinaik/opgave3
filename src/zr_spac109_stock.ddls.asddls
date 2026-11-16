@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock data model'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC109_STOCK as select from zspac109_stock

  association [0..1] to zspac109_product as _Product
  on $projection.ProductId = _Product.product_id

  association [0..1] to zspac109_wh as _Warehouse
  on $projection.WarehouseId = _Warehouse.warehouse_id
  
  association [0..1] to ZR_SPAC109_PRODUCT as _Product_stock
  on $projection.ProductId = _Product_stock.ProductId
  
  association [0..1] to ZR_SPAC109_WH as _Warehouse_stock
  on $projection.WarehouseId = _Warehouse_stock.WarehouseId
  
{
  key warehouse_id as WarehouseId,
  key product_id   as ProductId,
  amount           as Amount,
  
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at  as LastChangedAt,
  
  _Product.product_name     as ProductName,
  _Warehouse.warehouse_name as WarehouseName,
  _Warehouse.address        as WarehouseAddress,
  _Warehouse.city           as WarehouseCity,
  _Warehouse.postal_code    as PostalCode,
  
  _Product_stock.MinStock as MinStock,
  case when amount < _Product_stock.MinStock then 1 else 3 end as AmountCriticality,
  
  _Product_stock.CurrencyCode as CurrencyCode,

  @Semantics.amount.currencyCode: 'CurrencyCode'
  cast( cast( amount as abap.dec(13,0) ) * cast( _Product_stock.Price as abap.dec(13,2) )
        as abap.curr(15,2) ) as StockValue,
  
  _Product,
  _Warehouse,
  _Product_stock,
  _Warehouse_stock
}
