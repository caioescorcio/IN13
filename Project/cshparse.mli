type token =
  | EOF
  | INT of (int)
  | TRUE
  | FALSE
  | STRING of (string)
  | IDENT of (string)
  | ATIDENT of (string)
  | PATH of (string)
  | DEFINE
  | FUN
  | VAR
  | FOR
  | WHILE
  | IF
  | ELSE
  | IN
  | PASS
  | COMMA
  | PIPE
  | ANDAND
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUAL
  | GREATER
  | SMALLER
  | GREATEREQUAL
  | SMALLEREQUAL
  | SEMICOLON
  | SEMISEMI
  | LPAR
  | RPAR
  | LBRACKET
  | RBRACKET
  | LBRA
  | RBRA

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Cshast.expr
