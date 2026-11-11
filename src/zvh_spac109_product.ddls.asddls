@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Value Help'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZVH_SPAC109_PRODUCT
  as select from zspac109_product
{
  key product_id as ProductId,

      @Search.defaultSearchElement: true
      product_name as ProductName
}
