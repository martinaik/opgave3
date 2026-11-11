CLASS zcl_spac109_load_wh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_spac109_load_wh IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_warehouses TYPE TABLE OF zspac109_wh.

    lt_warehouses = VALUE #(

      ( client = sy-mandt
        warehouse_id = 1
        warehouse_name = 'Copenhagen Warehouse'
        address = 'Example Street 10'
        city = 'Copenhagen'
        postal_code = '2100' )

      ( client = sy-mandt
        warehouse_id = 2
        warehouse_name = 'Esbjerg Warehouse'
        address = 'Example Street 20'
        city = 'Esbjerg'
        postal_code = '6700' )

      ( client = sy-mandt
        warehouse_id = 3
        warehouse_name = 'Aarhus Warehouse'
        address = 'Example Street 30'
        city = 'Aarhus'
        postal_code = '8000' )

    ).

    MODIFY zspac109_wh FROM TABLE @lt_warehouses.

    out->write( |Processed { sy-dbcnt } warehouses.| ).

  ENDMETHOD.

ENDCLASS.
