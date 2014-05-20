# ezvm Chef Cookbook

This cookbook installs and configures [ezvm](https://github.com/vube/ezvm)

This does not actually execute ezvm, it just installs it.  The idea is that you
can install it, and then other recipes can install its local configuration and
execution plans, and then when you're done you run ezvm to have it update whatever
it needs to update.
