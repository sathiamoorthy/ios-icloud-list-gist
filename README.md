ios-icloud-list-gist
====================

This is an iOS example project that stores one list locally
and one list in the cloud.

The example uses recommendations and code snippets from Apple's
"Document-Based Application Programming Guide for iOS" which enapsulate
most iCloud interaction into a subclass of UIDocument, in this case
called List.

All of the significant code for the gist is in List.m and ListsManager.m, and
in the DetailViewController which implements the ListDelegate protocol.

There is as yet no implementation for basic things like:

* creating/deleting additional lists
* moving files back and forth from the cloud as the user's storage preferences change
* conflict resolution
* although the project began with the universal app template, apart from setting up the xib files, no effort has been made to make it work on the iPad.

Note that the iOS simulator does not have iCloud support. You have to get a 
provisioning profile for a real iPhone and run the app on that to see it
working.

Comments, questions and improvements are welcome.

~Brian Hill
Oakland, CA
brian@lingerhere.org
