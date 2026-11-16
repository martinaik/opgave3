@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product data model'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPAC109_PRODUCT as select from zspac109_product
{
  key product_id      as ProductId,
  product_name        as ProductName,
  product_description as ProductDescription,
  category            as Category,
  min_stock           as MinStock,
  product_status      as ProductStatus,
  currency_code       as CurrencyCode,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  price               as Price,
  
  cast( case
        when product_status = 'ACTIVE'   then 3
        when product_status = 'INACTIVE' then 1
        else 0
      end as abap.int1 ) as StatusCriticality,
      
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at     as LastChangedAt
}
