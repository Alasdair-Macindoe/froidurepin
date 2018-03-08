#
# froidurepin: An implementation of a parellel version of the Froidure-Pin algorithm
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
Print("Beginning Testing\n");
LoadPackage( "froidurepin" );

TestDirectory(DirectoriesPackageLibrary( "froidurepin", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
