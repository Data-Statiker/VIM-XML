## VIM-XML

VIM-XML is a script to expand yor XML File, so every element is in one line.

### How to use
* open your XML file in vim
* load script XMLCleaner.vim in CommandLine with ':so <Pfad>/XMLCleaner.vim' (example :so C:\XML\XMLCleaner.vim)
* run method XMLExpander() in CommandLine with ':call XMLExpander()'
* now you have a pretty printed XML structure

### Warning
If the content between a beginning and ending tag has spaces at the beginning, the spaces at the beginning will be deleted.
Example: \<test\>    Test data set\</test\> --> \<test\>Test data set\</test\>
