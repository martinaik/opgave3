@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SPAC109_PRODUCT provider contract transactional_query as projection on ZR_SPAC109_PRODUCT
{
  @EndUserText.label: 'Product ID'
  key ProductId,

  @EndUserText.label: 'Product Name'
  ProductName,
  
  @EndUserText.label: 'Product Description'
  ProductDescription,

  @EndUserText.label: 'Category'
  Category
}
