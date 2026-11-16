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
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZVH_SPAC109_CATEG', element: 'Category' },
    useForValidation: true
  }]
  Category,
  
  @EndUserText.label: 'Status'
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZVH_SPAC109_PSTAT', element: 'Status' },
    useForValidation: true
  }]
  ProductStatus,
  
  StatusCriticality,
  
  @EndUserText.label: 'Minimum stock'
  MinStock,
  
  @EndUserText.label: 'Currency'
  CurrencyCode,

  @EndUserText.label: 'Price'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  Price
}
