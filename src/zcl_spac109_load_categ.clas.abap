CLASS zcl_spac109_load_categ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_spac109_load_categ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_categ TYPE TABLE OF zspac109_categ.
    lt_categ = VALUE #(
      ( client = sy-mandt category = 'Clothing'    description = 'Clothing' )
      ( client = sy-mandt category = 'Footwear'    description = 'Footwear' )
      ( client = sy-mandt category = 'Accessories' description = 'Accessories' )
      ( client = sy-mandt category = 'Food'        description = 'Food' )
      ( client = sy-mandt category = 'Candy'       description = 'Candy' ) ).
    MODIFY zspac109_categ FROM TABLE @lt_categ.
    out->write( |Processed { sy-dbcnt } categories.| ).
  ENDMETHOD.
ENDCLASS.
