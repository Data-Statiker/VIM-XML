"  XMLCleaner.vim: (plugin) Liest ein unformatiertes XML ein und gibt es
"  formatiert (mit Einrückungen) aus
"  Last Change: Thu Sep 25 07:49 PM 2013 MET
"  Maintainer:  Data-Statiker
"  Version:     0.2, for Vim 7.4+

" TODO
" Don't delete Whitespace before content texts

" Funktion die das eingelesene XML aufbereitet und in einen neuen TAB schreibt
:function! XMLSchreibe(buffer2)

	:tabnext 2
	
	:let tb = ""

	:let z = 0
	:let r = 0
	:let za = 1
	:for r in range (0,len(a:buffer2)-1)
		
		" Alle Tags, die mit '<?' beginnen werden ohne Einrückungen in
		" das neue XML-TAB geschrieben
		:if (strpart(a:buffer2[r],0,2) == "<?")
			:call setline(za,a:buffer2[r])
			:redraw
		:else
			:if (z == 0)
				:let z = 1
			:endif
		:endif


		:if (z > 1) && (strpart(a:buffer2[r],0,2) != "<?")
			
			:let abPos = match(a:buffer2[r-1],"</")
			:if (abPos == -1) && (strpart(a:buffer2[r-1],0,1) == "<") && (strpart(a:buffer2[r-1],0,2) != "</") && (strpart(a:buffer2[r],0,1) == "<") && (strpart(a:buffer2[r-1],strlen(a:buffer2[r-1])-2,2) != "/>")
				:let tb = tb."\t"
			:endif
			:if (strpart(a:buffer2[r],0,2) == "</")
				:let tb = strpart(tb,0,strlen(tb)-1)
			:endif

			:if (strpart(a:buffer2[r],0,1) == "<")
				:call setline(za,tb."".a:buffer2[r])
			:endif

			:if (strpart(a:buffer2[r],0,1) != "<")
				:let za -= 1
				:let lineOld = getline(za)
				:call setline(za,lineOld."".a:buffer2[r])
				:unlet lineOld
			:endif

			:redraw
					
			:unlet abPos
		:endif
		
		" Das erste Tag, dass nicht mit '<?> beginnt wird ohne
		" Einrückung in das neue XML-TAB geschrieben
		:if (z == 1) && (strpart(a:buffer2[r],0,2) != "<?")
			:call setline(za,a:buffer2[r])
			:let z += 1
		:endif
	
	:let za += 1
	:endfor
	:unlet r
	:unlet z
	:unlet tb
	:unlet za
:endf

" Funktion zur Eleminierung von Whitespace vor dem ersten Zeichen eines
" Strings
:function! XMLHarmonize(repl2)
	
	:let repl3 = a:repl2
	:let pos = match(repl3,"<")
	
	:let x = 0
	:for x in range (0,pos)
		:if (strpart(repl3,0,1) == " ") || (strpart(repl3,0,1) == "\t")
			:let repl3 = strpart(repl3,1,strlen(repl3)-1)
		:else
			:break
		:endif
	:endfor
	:unlet x

	:unlet pos
	:return repl3
	:unlet repl3
:endf

" Liest das Original-XML in TAB 1 ein und speichert Einzelne Tags in der Liste
" buffer
:function! XMLExpander()
	:tabnext 1
	:let buffer = []
	:let i = 1
	:while i <= line("$")
	
		:let line = getline(i)
		:let bufferZeile = split(line,">")
	
		:let a = 0
		:for a in range (0, len(bufferZeile)-1)

			:let repl = XMLHarmonize(bufferZeile[a])
			:call add(buffer,repl.">")
		
			:unlet repl
		:endfor
		:unlet a

		:let i += 1
	
	:endwhile
	:unlet i

	:call XMLSchreibe(buffer)

:endf
