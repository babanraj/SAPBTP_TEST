FUNCTION YTEST_BTP_FUNCTIONMODULE_MOVE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_INPUT) TYPE  CHAR40 DEFAULT 'Nothing'
*"  EXPORTING
*"     REFERENCE(EV_OUTPUT) TYPE  CHAR40
*"----------------------------------------------------------------------

ev_output = iv_input.



ENDFUNCTION.
