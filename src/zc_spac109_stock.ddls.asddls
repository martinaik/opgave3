@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SPAC109_STOCK provider contract transactional_query as projection on ZR_SPAC109_STOCK
{
  @EndUserText.label: 'Warehouse'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZVH_SPAC109_WH',
      element: 'WarehouseId'
    }
  }]  
  @ObjectModel.foreignKey.association: '_Warehouse_stock'
  key WarehouseId,
  
  @EndUserText.label: 'Product'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZVH_SPAC109_PRODUCT',
      element: 'ProductId'
    }
  }]
  @ObjectModel.foreignKey.association: '_Product_stock'
  key ProductId,
  
  @EndUserText.label: 'Amount'
  Amount,
  
  @EndUserText.label: 'Product Name'
  ProductName,
  
  @EndUserText.label: 'Warehouse Name'
  WarehouseName,
  
  @EndUserText.label: 'Warehouse Adress'
  WarehouseAddress,
  
  @EndUserText.label: 'Warehouse City'
  WarehouseCity,
  
  @EndUserText.label: 'Postal Code'
  PostalCode,
  
  MinStock,
  AmountCriticality,
  
  @EndUserText.label: 'Currency'
  CurrencyCode,

  @EndUserText.label: 'Stock value'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  StockValue,
  
  _Product,
  _Warehouse,
  
  _Product_stock   : redirected to ZC_SPAC109_PRODUCT,
  _Warehouse_stock : redirected to ZC_SPAC109_WH
}
