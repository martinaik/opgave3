CLASS zcl_spac109_load_products DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_spac109_load_products IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_products TYPE TABLE OF zspac109_product.

    lt_products = VALUE #(

      ( client = sy-mandt
        product_id = 1
        product_name = 'T-shirt'
        product_description = 'Cotton T-shirt, black'
        category = 'Clothing' )

      ( client = sy-mandt
        product_id = 2
        product_name = 'Jeans'
        product_description = 'Blue denim jeans'
        category = 'Clothing' )

      ( client = sy-mandt
        product_id = 3
        product_name = 'Sneakers'
        product_description = 'White casual sneakers'
        category = 'Footwear' )

      ( client = sy-mandt
        product_id = 4
        product_name = 'Backpack'
        product_description = 'Travel backpack'
        category = 'Accessories' )

      ( client = sy-mandt
        product_id = 5
        product_name = 'Sunglasses'
        product_description = 'UV-protective sunglasses'
        category = 'Accessories' )

    ).

    MODIFY zspac109_product FROM TABLE @lt_products.

    out->write( |Processed { sy-dbcnt } products.| ).

  ENDMETHOD.

ENDCLASS.
