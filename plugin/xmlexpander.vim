"  xmlexpander.vim: (plugin) Read a XML and give it out formatted
"  Last Change: Sat Apr 19 08:55 PM 2015 MET
"  Maintainer:  Data-Statiker
"  Version:     0.3, for Vim 7.4+

" Whats New:
" Version 0.3
" *	New name: xmlexpander
" *	Redefine functions and variables (xmlexpander)
" *	New function xmlexpander#isContentText(text) to check if a text has to be harmonized

" Function that writes the xml in the current window
:function! xmlexpander#write(xmlContent)

	:execute "normal" "gg"
	:execute "normal" "dG"

	:let tb = ""

	:let z = 0
	:let r = 0
	:let za = 1
	:for r in range (0,len(a:xmlContent)-1)
		
		" All tags starting with '<?' are write without insertion
		:if (strpart(a:xmlContent[r],0,2) == "<?")
			:call setline(za,a:xmlContent[r])
			:redraw
		:else
			:if (z == 0)
				:let z = 1
			:endif
		:endif


		:if (z > 1) && (strpart(a:xmlContent[r],0,2) != "<?")
			
			:let abPos = match(a:xmlContent[r-1],"</")
			:if (abPos == -1) && (strpart(a:xmlContent[r-1],0,1) == "<") && (strpart(a:xmlContent[r-1],0,2) != "</") && (strpart(a:xmlContent[r],0,1) == "<") && (strpart(a:xmlContent[r-1],strlen(a:xmlContent[r-1])-2,2) != "/>")
				:let tb = tb."\t"
			:endif
			:if (strpart(a:xmlContent[r],0,2) == "</")
				:let tb = strpart(tb,0,strlen(tb)-1)
			:endif

			:if (strpart(a:xmlContent[r],0,1) == "<")
				:call setline(za,tb."".a:xmlContent[r])
			:endif

			:if (strpart(a:xmlContent[r],0,1) != "<")
				:let za -= 1
				:let lineOld = getline(za)
				:call setline(za,lineOld."".a:xmlContent[r])
				:unlet lineOld
			:endif

			:redraw
					
			:unlet abPos
		:endif
		
		" The first tag starting not with '<?> is wrote without
		" insertion
		:if (z == 1) && (strpart(a:xmlContent[r],0,2) != "<?")
			:call setline(za,a:xmlContent[r])
			:let z += 1
		:endif
	
	:let za += 1
	:endfor
	:unlet r
	:unlet z
	:unlet tb
	:unlet za
:endf

" This function eliminates whitespace in front of the first character of a
" string
:function! xmlexpander#harmonize(repl2)
	
	:let repl3 = a:repl2
	:let pos = match(repl3,"<")
	
	:let harmonize = xmlexpander#isContentText(repl3)

	:if harmonize == "false"

		:let x = 0
		:for x in range (0,pos)
			:if (strpart(repl3,0,1) == " ") || (strpart(repl3,0,1) == "\t")
				:let repl3 = strpart(repl3,1,strlen(repl3)-1)
			:else
				:break
			:endif
		:endfor
		:unlet x

	:endif

	:unlet pos
	:return repl3	
:endf

" Function returns if the text is a text between tags
" So the program know if the text has to be harmonized
:function! xmlexpander#isContentText(text)

	:let isContent = "false"

	:let i = 0
	:for i in range(0,strlen(a:text)-1)
		:if strpart(a:text,i,1) == " " || strpart(a:text,i,1) == "\t"
			:continue
		:elseif strpart(a:text,i,1) != "<"
			:let isContent = "true"
			:break
		:else
			:break
		:endif
	:endfor

	:return isContent

:endf

" This function reads the original XML file and saves separate tags in the
" list buffer
:function! xmlexpander#expand()
	
	:let buffer = []
	:let i = 1
	:while i <= line("$")
	
		:let line = getline(i)
		:let bufferLine = split(line,">")
	
		:let a = 0
		:for a in range (0, len(bufferLine)-1)

			:let repl = xmlexpander#harmonize(bufferLine[a])
			:call add(buffer,repl.">")

			:unlet repl
		:endfor
		:unlet a

		:let i += 1
	
	:endwhile
	:unlet i

	:call xmlexpander#write(buffer)

:endf
