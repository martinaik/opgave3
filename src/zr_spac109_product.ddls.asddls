@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product data model'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPAC109_PRODUCT as select from zspac109_product
{
  key product_id      as ProductId,
  product_name        as ProductName,
  product_description as ProductDescription,
  category            as Category,
      
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at     as LastChangedAt
}
