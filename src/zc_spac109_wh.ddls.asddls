@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZC_SPAC109_WH provider contract transactional_query as projection on ZR_SPAC109_WH
{
  @EndUserText.label: 'Warehouse ID'
  key WarehouseId,
  
  @EndUserText.label: 'Warehouse Name'
  WarehouseName,
  
  @EndUserText.label: 'Address'
  Address,
  
  @EndUserText.label: 'City'
  City,
  
  @EndUserText.label: 'Postal Code'
  PostalCode
}
