# README

_Time Clock_ is a small Cocoa program to facilitate simpler analysis of `.timeclock` files
managed by the _Emacs_ `timeclock.el` functions.

The program reads the `.timeclock` file from the user's home directory and stores the data
in an internal CoreData storage. This storage is then bound to the user interface.

The `.timeclock` file (and internal storage) is organized into *projects* and *work items*.
The entries (for clocking in should be formatted as follows:

    i yyyy/mm/dd hh:mm:ss [project]
    o yyyy/mm/dd hh:mm:ss description or reason for clocking out
    
The entries for clocking out do not _have to_ have any associated description. Only the timestamp
for clocking out is analyzed.

See [Emacs timeclock.el documentation](https://git.savannah.gnu.org/cgit/emacs.git/tree/lisp/calendar/timeclock.el?h=emacs-28#n328)

# User Interface

The user interface allows to select one or multiple of the projects. This shows the entries
for the projects and the total accumulated time for the projects.

With the menu entry `File -> Print` a report is generated. The report contains the selected
project and one entry per day containing the accumulated hours for the day and the list of
work items for the day.

# Notes

* The internal storage is reinitialized on startup. The storage is not persistent yet! Do not delete the entries from the `.timestamp` file.




