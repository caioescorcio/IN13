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

open Parsing;;
let _ = parse_error;;
# 2 "cshparse.mly"
  open Cshast;;

  (* Fonction utilitaire pour le sucre syntaxique let f x y z = ...
     devant générer la même chose que let f = fun x -> fun y -> fun z -> ... *)
  let rec mkfun vars e =
    match vars with
    | [] -> e 
    | x :: y -> EFun( x, mkfun y e )
  ;;
# 54 "cshparse.ml"
let yytransl_const = [|
    0 (* EOF *);
  258 (* TRUE *);
  259 (* FALSE *);
  262 (* DEFINE *);
  263 (* FUNCTION *);
  264 (* VAR *);
  265 (* IF *);
  266 (* THEN *);
  267 (* ELSE *);
  268 (* PASS *);
  269 (* COMMA *);
  270 (* PIPE *);
  271 (* PLUS *);
  272 (* MINUS *);
  273 (* MULT *);
  274 (* DIV *);
  275 (* EQUAL *);
  276 (* GREATER *);
  277 (* SMALLER *);
  278 (* GREATEREQUAL *);
  279 (* SMALLEREQUAL *);
  280 (* SEMICOLON *);
  281 (* LPAR *);
  282 (* RPAR *);
  283 (* LBRACKET *);
  284 (* RBRACKET *);
  285 (* FROM *);
  286 (* TO *);
  287 (* LBRA *);
  288 (* RBRA *);
  289 (* SEMISEMI *);
  290 (* FOR *);
  291 (* WHILE *);
  292 (* IN *);
  293 (* FUN *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  260 (* STRING *);
  261 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\003\000\003\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\002\000\003\000\002\000\000\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\008\000\000\000\000\000\000\000\
\004\000\002\000\001\000\000\000\006\000\005\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\009\000"

let yysindex = "\002\000\
\251\254\000\000\255\254\251\254\000\000\228\254\239\254\255\254\
\000\000\000\000\000\000\255\254\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\233\254\000\000\000\000\000\000\231\254\233\254\
\000\000\000\000\000\000\233\254\000\000\000\000"

let yygindex = "\000\000\
\005\000\000\000\000\000\250\255"

let yytablesize = 28
let yytable = "\003\000\
\007\000\013\000\001\000\008\000\011\000\014\000\012\000\003\000\
\010\000\007\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\004\000"

let yycheck = "\005\001\
\024\001\008\000\001\000\005\001\033\001\012\000\024\001\033\001\
\004\000\033\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\033\001"

let yynames_const = "\
  EOF\000\
  TRUE\000\
  FALSE\000\
  DEFINE\000\
  FUNCTION\000\
  VAR\000\
  IF\000\
  THEN\000\
  ELSE\000\
  PASS\000\
  COMMA\000\
  PIPE\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  EQUAL\000\
  GREATER\000\
  SMALLER\000\
  GREATEREQUAL\000\
  SMALLEREQUAL\000\
  SEMICOLON\000\
  LPAR\000\
  RPAR\000\
  LBRACKET\000\
  RBRACKET\000\
  FROM\000\
  TO\000\
  LBRA\000\
  RBRA\000\
  SEMISEMI\000\
  FOR\000\
  WHILE\000\
  IN\000\
  FUN\000\
  "

let yynames_block = "\
  INT\000\
  STRING\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'phrase) in
    Obj.repr(
# 50 "cshparse.mly"
                        ( _1 )
# 187 "cshparse.ml"
               : Cshast.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Cshast.expr) in
    Obj.repr(
# 51 "cshparse.mly"
                      ( _2 )
# 194 "cshparse.ml"
               : Cshast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 56 "cshparse.mly"
         (_1)
# 201 "cshparse.ml"
               : 'phrase))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 60 "cshparse.mly"
                ( EIdent(_1) )
# 209 "cshparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 61 "cshparse.mly"
                        ( _1 )
# 217 "cshparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 64 "cshparse.mly"
               (EIdent (_1) :: _2)
# 225 "cshparse.ml"
               : 'args))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "cshparse.mly"
    ([])
# 231 "cshparse.ml"
               : 'args))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Cshast.expr)
