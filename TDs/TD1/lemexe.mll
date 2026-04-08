{ 
    
    exception UnknownLexeme 

    type lexeme = PLUS | MINUS | TIMES | DIVIDE 
    | PARANTHESIS_RIGHT | PARANTHESIS_LEFT | INT of int | VARIABLE | EOF 
    | LET | IN

}

let integer = ['0' - '9']
let var = ['a' - 'z'] | ['A' - 'Z'] *

rule analyze = parse
    | "let"     {LET}
    | "in"      {IN}
    | "//"      {simple_comment lexbuf}
    | "/*"      {general_comment lexbuf}
    | "+"       {PLUS}
    | "-"       {MINUS}
    | "*"       {TIMES}
    | "/"       {DIVIDE}
    | "("       {PARANTHESIS_LEFT}  
    | ")"       {PARANTHESIS_RIGHT}  
    | integer   {INT}
    | eof       {EOF}
    | var       {VARIABLE}
    | _         {UnknownLexeme}

and simple_comment = parse
    | "\n"      {analyze lexbuf}
    | eof       {EOF}
    | _         {comments lexbuf}

and general_comment = parse
    | "*/"      {analyze lexbuf}
    | eof       {EOF}
    | _         {general_comment lexbuf}


{  }