### Getting Started

With the XMLExpander extension plugin for vim you can make your XML file
clear. The XMLExpander is a pretty printer for XML.

When you have the problem that your xml files are e.g. in one line or have not
clear insertions this plugin could help you. After running the XMLExpander
every opening and ending tag is in one line and have clear insertions.

First install the plugin: |xmlexpander-install|

To run the XMLExpander do the following:
- load the input XML file
- execute the XMLExpander: menu Plugin--XMLExpander <run>

Now you have a pretty printed XML file (in the same VIM window!).

Warning:
The XML File must be syntactical correct! The script do not check this.

For further details read the vim help file doc/xmlexpander.txt
or in VIM :help xmlexpander

### Whats New
Version 0.3
-	New name: xmlexpander
-	Redefine functions and variables (xmlexpander)
-	New function xmlexpander#isContentText(text) to check if a text has to be harmonized


### Installation

VIMBALL:
Download the vimball file xmlexpander.vmb from:
http://www.vim.org/

Install the vimball file with VIM
1 Download the file xmlexpander.vmb
2 vim path/xmlexpander.vmb
3 :so %
4 :q

Now you have the menu Plugin--XMLExpander <Run>

HELP FILE:
To activate the helpfile in VIM type in command mode:
 :helptags ~/.vim/doc
 OR (Windows)
 :helptags C:\Users\YourUsername\vimfiles\doc

Then you can open the helpfile with ':help xmlexpander'

GITHUB:

GITHUB Repository:
https://github.com/Data-Statiker/VIM-XML

When you have the files from GITHUB:
Copy the files of the folders 'autoload', 'doc' and 'plugin' to your
local vimfiles:
 ~/.vim/doc
 OR (Windows)
 C:\Users\YourUsername\vimfiles\doc


### Example

Example of an XML before running the XMLExpander: 
\<?xml/><? some text/><Test id="First"><Testcase><TA id="1">one</TB> | line 1	
\<TB>two</TB></Testcase><Testcase>	<TA>one</TB><TB>two</TB>     | line 2
\</Testcase>  <Testcase>    three</Testcase><Testcase/></Test>       | line 3

The XML after running the XMLExpander looks like this:
\<?xml/>                                                             | line 1
\<? some text/>                                                      | line 2
\<Test id="First">                                                   | line 3
\       <Testcase>                                                   | line 4
\               <TA id="1">one</TB>                                  | line 5
\               <TB>two</TB>                                         | line 6
\       </Testcase>                                                  | line 7
\       <Testcase>                                                   | line 8
\               <TA>one</TB>                                         | line 9
\               <TB>two</TB>                                         | line 10
\       </Testcase>                                                  | line 11
\       <Testcase>    three</Testcase>                               | line 12
\       <Testcase/>                                                  | line 13
</Test>                                                              | line 14
