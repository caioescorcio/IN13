{ 
    
    exception UnknownChar 

}

let end_word = [' ' '\t']
let letter = [^ ' ' '\t' '\n']
let new_line = '\n'

rule count nbchars nbwords nblines = parse
    | letter                {count_word (nbchars+1) nbwords nblines lexbuf} 
    | new_line              {count (nbchars+1) nbwords (nblines+1) lexbuf}
    | end_word              {count_word (nbchars+1) nbwords nblines lexbuf} 
    | eof                   {nbchars, nbwords, nblines}
    | _                     {raise UnknownChar}

and count_word nbchars nbwords nblines = parse
    | letter                {count_word (nbchars+1) nbwords nblines lexbuf}
    | new_line              {count (nbchars+1) (nbwords+1) (nblines+1) lexbuf}
    | end_word              {count (nbchars+1) (nbwords+1) nblines lexbuf}
    | eof                   {nbchars, nbwords, nblines}
    | _                     {raise UnknownChar}

{  }