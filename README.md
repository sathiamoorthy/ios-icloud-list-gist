ios-icloud-list-gist
====================

This is an iOS example project that stores one list locally
and one list in the cloud.

The most important code for the gist is in List.m and ListsManager.m.

There is as yet no implementation for basic things like:

* creating/deleting additional lists
* moving files back and forth from the cloud as the user's storage preferences change
* conflict resolution
* although this is a "universal app" no real effort has been made to make it work on the iPad

Note that the iOS simulator does not have iCloud support. You have to get a 
provisioning profile for a real iPhone and run the app on that to see it working.

