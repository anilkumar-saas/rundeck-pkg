# rundeck-pkg
Krux specific packaging of rundeck.

## Packaging

* Run ```./package.sh``` from the root of this checkout

## Bundled plugins

Plugins are defined in the [plugins.list](plugins.list-2.5.2-1) file.

## Updating the source

* Grab the latest *debian* release from [rundeck](http://rundeck.org/downloads.html)
* Extract the package into the root of this repository. For example:
  * ```dpkg --extract rundeck-2.5.2-1-GA.deb rundeck-2.5.2-1```
* Update the ```rundeck``` symlink to point to the new directory
* If it's a **Major or Minor version** upgrade, be sure to update plugins.list, and possibly update the symlink.
* Commit your changes
