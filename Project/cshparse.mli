type token =
  | EOF
  | INT of (int)
  | TRUE
  | FALSE
  | STRING of (string)
  | IDENT of (string)
  | DEFINE
  | FUNCTION
  | VAR
  | IF
  | THEN
  | ELSE
  | PASS
  | COMMA
  | PIPE
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
  | LPAR
  | RPAR
  | LBRACKET
  | RBRACKET
  | FROM
  | TO
  | LBRA
  | RBRA
  | SEMISEMI
  | FOR
  | WHILE
  | IN
  | FUN

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Cshast.expr
