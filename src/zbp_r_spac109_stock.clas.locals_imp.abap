CLASS lhc_ZR_SPAC109_STOCK DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Stock RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Stock RESULT result.

    METHODS validateUniqueStock
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateUniqueStock.

    METHODS validateNonNegativeAmount
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateNonNegativeAmount.

    METHODS validateProduct FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateProduct.

    METHODS validateWarehouse FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateWarehouse.

ENDCLASS.

CLASS lhc_ZR_SPAC109_STOCK IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

  ENDMETHOD.

  METHOD validateUniqueStock.

    LOOP AT keys INTO DATA(stock_key).

      SELECT SINGLE warehouse_id
        FROM zspac109_stock
        WHERE warehouse_id = @stock_key-WarehouseId
          AND product_id = @stock_key-ProductId
        INTO @DATA(existing_warehouse_id).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky = stock_key-%tky
        ) TO failed-stock.

        APPEND VALUE #(
          %tky = stock_key-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'This product already exists in this warehouse'
          )
          %element-WarehouseId = if_abap_behv=>mk-on
          %element-ProductId = if_abap_behv=>mk-on
        ) TO reported-stock.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateNonNegativeAmount.

    READ ENTITIES OF ZR_SPAC109_STOCK IN LOCAL MODE
      ENTITY Stock
      FIELDS ( Amount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(stocks).

    LOOP AT stocks INTO DATA(stock).

      IF stock-Amount < 0.

        APPEND VALUE #(
          %tky = stock-%tky
        ) TO failed-stock.

        APPEND VALUE #(
          %tky = stock-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Stock amount cannot be negative'
          )
          %element-Amount = if_abap_behv=>mk-on
        ) TO reported-stock.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateProduct.
    READ ENTITIES OF zr_spac109_stock IN LOCAL MODE
      ENTITY Stock
        FIELDS ( ProductId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(stocks).

    LOOP AT stocks INTO DATA(stock).

      APPEND VALUE #( %tky        = stock-%tky
                      %state_area = 'VALIDATE_PRODUCT' ) TO reported-stock.

      CHECK stock-ProductId IS NOT INITIAL.

      SELECT SINGLE product_id
        FROM zspac109_product
        WHERE product_id = @stock-ProductId
        INTO @DATA(lv_product_id).

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = stock-%tky ) TO failed-stock.
        APPEND VALUE #( %tky        = stock-%tky
                        %state_area = 'VALIDATE_PRODUCT'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = |The product { stock-ProductId } does not exist.| )
                        %element-ProductId = if_abap_behv=>mk-on ) TO reported-stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateWarehouse.
    READ ENTITIES OF zr_spac109_stock IN LOCAL MODE
      ENTITY Stock
        FIELDS ( WarehouseId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(stocks).

    LOOP AT stocks INTO DATA(stock).

      APPEND VALUE #( %tky        = stock-%tky
                      %state_area = 'VALIDATE_WAREHOUSE' ) TO reported-stock.

      CHECK stock-WarehouseId IS NOT INITIAL.

      SELECT SINGLE warehouse_id
        FROM zspac109_wh
        WHERE warehouse_id = @stock-WarehouseId
        INTO @DATA(lv_warehouse_id).

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = stock-%tky ) TO failed-stock.
        APPEND VALUE #( %tky        = stock-%tky
                        %state_area = 'VALIDATE_WAREHOUSE'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = |The warehouse { stock-WarehouseId } does not exist.| )
                        %element-WarehouseId = if_abap_behv=>mk-on ) TO reported-stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

