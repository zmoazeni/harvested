3.0.0 - Unreleased
  * Require Ruby 2.0+
  * Allow OAuth authentication (Thanks Brendan Loudermilk - @bloudermilk)
  * Allow expenses_by_project to be retrieved (Thanks Jordan Yeo - @jordanyeo)
  * Reports now pass through any remaining options (Thanks Philip Arndt - @parndt)
2.0.0 - April 23, 2014
  * Every connection must be SSL
1.2.0 - February 21, 2014
  * Adds time.trackable_projects: projects that the current user can create entries for
  * Show hint on error for projects.all as unprivileged user
1.1.0 - December 13, 2013
  * Adds ability to toggle timers (thanks Eli Fatsi - @efatsi)
1.0.1 - June 21, 2013
  * Adds ability to pass updated_since paramter to report methods (thanks Pete McWilliams)
  * Adds ability to create time entries for a given user
1.0.0 - April 26, 2013
  * Same as 0.6.4 - This should have been v1.0 long ago.
0.6.4 - October 24, 2012
  * Removes yard and redcarpet dependencies (added on accident)
0.6.3 - October 24, 2012
  * Adds task activation (Thanks Mark Rickert - @markrickert)
  * Adds basic invoice support (Thanks Jeffrey Lee - @jlee42)
  * Adds basic invoice payment support (Thanks Adam Doeler - @releod)
0.6.2 - August 25, 2012
  * Fixes Mash constructor errors
0.6.1 - August 22, 2012
  * Adds options to "all" finder (thanks Mikel Lindsaar)
  * Adds Unauthorized error type (thanks @bcobb)
0.6.0 - August 22, 2012
  * Replaces Dash with Mash
0.5.3 - August 21, 2012
  * Adds new fields has_timesheet_2012_beta and timesheet_2012_beta_control_group to Users (thanks Aldric Giacomoni)
0.5.2 - August 17, 2012
  * Adds new field password_change_required to Users
0.5.1 - June 27, 2012
  * Updates README and harvested_credentials.example.yml with warnings about normal accounts
0.5.0 - June 18, 2012
  * Bugfixes on User: https://github.com/zmoazeni/harvested/pull/26
  * Bugfixes on TimeEntry: https://github.com/zmoazeni/harvested/pull/25
0.4.0 - August 4, 2011
  * Large rewrite of codebase
  * Rewrite of library to use JSON instead of XML
  * Rewrite of tests to use rspec instead of cucumber
  * Brings in VCR to help cache test responses
  * Implements more reporting functionality
  * Implements most of the invoice functionality. Creating/Editing/Updating is disabled due to Harvest API issue
  * Consolidates various forks (thanks Chris Ritterdorf, bricooke, Michelle Moon Lee, tkwong, Steve McKinney, and others that helped but aren't in the git log!)
  * Tests passing against MRI 1.8, 1.9, JRuby, and Rubinius
0.3.3 - January 27, 2010
  * Adds fields to TaskAssignment (Quilted)
0.3.2 - January 27, 2010
  * Adds of_user support to Time Entry (Benjamin Wong - tkwong)
0.3.1 - October 14, 2010
  * Updates docs removing :ssl => false since Harvest released SSL to everyone
  * Adds department to the User model (Steve McKinney - )
0.3.0 - April 11, 2010
  * Adds users
  * Adds clients
  * Adds contacts
  * Adds expense categories
  * Adds expenses
  * Adds projects
  * Adds tasks
  * Adds task assignments
  * Adds user assignments
  * Adds time tracking
  * Adds reporting
  * Adds account information
  * Adds common errors
  * Adds Harvest#hardy_client
