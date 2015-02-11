#############################################################################
##
##  Notify the functions to be defined for {\VE}.
##
AUTO( ReadPkg( "ve", "gap", "ve" ),
      VE, PrintVEInput, CallVE, VEOutput );

AUTO( ReadPkg( "ve", "gap", "mtx" ),
      VEMeatAxe, VEMeatAxeMat );

#############################################################################
##
##  Read 've.g' if this is not yet done.
##  This is necessary because 'FpAlgebraOps.OperationQuotientModule'
##  must overlay the error message that is placed there originally.
##
VE;

