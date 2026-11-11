@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Value Help'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZVH_SPAC109_WH as select from zspac109_wh
{
  key warehouse_id as WarehouseId,

  @Search.defaultSearchElement: true
  warehouse_name as WarehouseName,

  @Search.defaultSearchElement: true
  city as City
}
