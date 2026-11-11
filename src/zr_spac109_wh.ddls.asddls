@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse data model'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPAC109_WH as select from zspac109_wh
{
  key warehouse_id as WarehouseId,
  warehouse_name   as WarehouseName,
  address          as Address,
  city             as City,
  postal_code      as PostalCode,
      
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at  as LastChangedAt
}
