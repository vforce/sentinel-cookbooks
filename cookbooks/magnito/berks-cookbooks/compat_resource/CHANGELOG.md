# compat_resource Cookbook CHANGELOG

This file is used to list changes made in each version of the compat_resource cookbook.

## 12.14.6 (2016-09-20)

- Update backported codebase to Chef 12.14.77 which brings in yum_repository updates and why-run enabled by default in custom resources

## 12.14.5 (2016-09-19)

- Prevent spamming messages in Chefspec runs for cookbooks that depend on compat_resource

## 12.14.4 (2016-09-19)

- Fix delayed notifications cloning

## 12.14.3 (2016-09-12)

- Fix subscribes notifications

## 12.14.2 (2016-09-09)

- Improve documentation
- keep ChefCompat::Resource defined even if we don't load

## 12.14.1 (2016-09-07)

- add yum_repository resource from Chef 12.14
- Update the minimum chef version in the metadata to 12.1
- Added maintainers files
- suppress constant redef warnings when running chefspec
