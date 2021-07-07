class YCL_BTP_CLASS_MOVE definition
  public
  final
  create public .

public section.

  methods CHECK_PUBLIC
    returning
      value(LV_RETURN) type CHAR40 .
protected section.
private section.

  methods CHECK_PRIVATE
    returning
      value(LV_RETURN) type CHAR40 .
  methods CHECK_PROTECTED
    returning
      value(LV_RETURN) type CHAR40 .
ENDCLASS.



CLASS YCL_BTP_CLASS_MOVE IMPLEMENTATION.


  method CHECK_PRIVATE.

    lv_return = 'CHECK_PRIVATE'.

  endmethod.


  method CHECK_PROTECTED.

    lv_return = 'CHECK_PROTECTED'.

  endmethod.


  method CHECK_PUBLIC.

    lv_return = 'CHECK_PUBLIC'.

  endmethod.
ENDCLASS.
