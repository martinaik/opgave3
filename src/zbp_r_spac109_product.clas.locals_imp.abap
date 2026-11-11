CLASS lhc_Product DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Product RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Product RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Product.

    METHODS validateUniqueName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Product~validateUniqueName.

    METHODS validateMandatory FOR VALIDATE ON SAVE
      IMPORTING keys FOR Product~validateMandatory.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE Product.

ENDCLASS.

CLASS lhc_Product IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

  ENDMETHOD.

  METHOD earlynumbering_create.
    LOOP AT entities INTO DATA(entity_with_id) WHERE ProductId IS NOT INITIAL.
      APPEND VALUE #( %cid      = entity_with_id-%cid
                      %is_draft = entity_with_id-%is_draft
                      %key      = entity_with_id-%key ) TO mapped-product.
    ENDLOOP.

    DATA(entities_wo_id) = entities.
    DELETE entities_wo_id WHERE ProductId IS NOT INITIAL.
    CHECK entities_wo_id IS NOT INITIAL.

    SELECT MAX( product_id ) FROM zspac109_product INTO @DATA(lv_max_active).
    SELECT MAX( productid )  FROM zdspac109_prod   INTO @DATA(lv_max_draft).

    DATA(lv_next) = nmax( val1 = lv_max_active val2 = lv_max_draft ).

    LOOP AT entities_wo_id INTO DATA(entity).
      lv_next += 1.
      APPEND VALUE #( %cid      = entity-%cid
                      %is_draft = entity-%is_draft
                      ProductId = lv_next ) TO mapped-product.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateUniqueName.
    READ ENTITIES OF zr_spac109_product IN LOCAL MODE
      ENTITY Product
        FIELDS ( ProductName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(products).

    LOOP AT products INTO DATA(product).

      APPEND VALUE #( %tky        = product-%tky
                      %state_area = 'VALIDATE_NAME' ) TO reported-product.

      CHECK product-ProductName IS NOT INITIAL.

      SELECT SINGLE product_id
        FROM zspac109_product
        WHERE upper( product_name ) = @( to_upper( condense( product-ProductName ) ) )
          AND product_id <> @product-ProductId
        INTO @DATA(lv_existing_id).

      IF sy-subrc = 0.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky        = product-%tky
                        %state_area = 'VALIDATE_NAME'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = |The product "{ product-ProductName }" already exists (ID { lv_existing_id }).| )
                        %element-ProductName = if_abap_behv=>mk-on ) TO reported-product.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMandatory.
    READ ENTITIES OF zr_spac109_product IN LOCAL MODE
      ENTITY Product
        FIELDS ( ProductName ProductDescription Category )
        WITH CORRESPONDING #( keys )
      RESULT DATA(products).

    LOOP AT products INTO DATA(product).

      APPEND VALUE #( %tky        = product-%tky
                      %state_area = 'VALIDATE_MANDATORY' ) TO reported-product.

      DATA(lv_name)     = condense( product-ProductName ).
      DATA(lv_description)     = condense( product-ProductDescription ).
      DATA(lv_category) = condense( product-Category ).

      IF lv_name IS INITIAL.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky        = product-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Product name is required' )
                        %element-ProductName = if_abap_behv=>mk-on ) TO reported-product.
      ENDIF.

      IF lv_description IS INITIAL.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky        = product-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Product description is required.' )
                        %element-ProductDescription = if_abap_behv=>mk-on ) TO reported-product.
      ENDIF.

      IF lv_category IS INITIAL.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky        = product-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Category is required.' )
                        %element-Category = if_abap_behv=>mk-on ) TO reported-product.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_delete.
    LOOP AT keys INTO DATA(key).

      SELECT SINGLE product_id
        FROM zspac109_stock
        WHERE product_id = @key-ProductId
        INTO @DATA(lv_stock_product).

      IF sy-subrc = 0.
        APPEND VALUE #( %tky = key-%tky ) TO failed-product.
        APPEND VALUE #( %tky = key-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |The product { key-ProductId } has stock and cannot be deleted.| ) ) TO reported-product.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
