type token =
  | EOF
  | INT of (int)
  | IDENT of (string)
  | TRUE
  | FALSE
  | STRING of (string)
  | COLONEQUAL
  | WHILE
  | DO
  | DONE
  | BEGIN
  | END
  | RETURN
  | VAR
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUALEQUAL
  | GREATER
  | SMALLER
  | GREATEREQUAL
  | SMALLEREQUAL
  | LPAR
  | RPAR
  | SEMICOLON
  | COMMA
  | LBRACKET
  | RBRACKET
  | IF
  | THEN
  | ELSE
  | ENDIF
  | PRINT

open Parsing;;
let _ = parse_error;;
# 2 "impparse.mly"
open Impast ;;
# 42 "impparse.ml"
let yytransl_const = [|
    0 (* EOF *);
  259 (* TRUE *);
  260 (* FALSE *);
  262 (* COLONEQUAL *);
  263 (* WHILE *);
  264 (* DO *);
  265 (* DONE *);
  266 (* BEGIN *);
  267 (* END *);
  268 (* RETURN *);
  269 (* VAR *);
  270 (* PLUS *);
  271 (* MINUS *);
  272 (* MULT *);
  273 (* DIV *);
  274 (* EQUALEQUAL *);
  275 (* GREATER *);
  276 (* SMALLER *);
  277 (* GREATEREQUAL *);
  278 (* SMALLEREQUAL *);
  279 (* LPAR *);
  280 (* RPAR *);
  281 (* SEMICOLON *);
  282 (* COMMA *);
  283 (* LBRACKET *);
  284 (* RBRACKET *);
  285 (* IF *);
  286 (* THEN *);
  287 (* ELSE *);
  288 (* ENDIF *);
  289 (* PRINT *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* IDENT *);
  261 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\004\000\004\000\006\000\006\000\003\000\
\007\000\007\000\009\000\009\000\008\000\008\000\010\000\010\000\
\010\000\010\000\010\000\010\000\010\000\010\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\011\000\011\000\012\000\012\000\
\014\000\014\000\013\000\013\000\013\000\013\000\013\000\000\000"

let yylen = "\002\000\
\001\000\002\000\001\000\003\000\006\000\000\000\002\000\008\000\
\000\000\002\000\000\000\003\000\001\000\002\000\007\000\005\000\
\004\000\007\000\003\000\003\000\005\000\005\000\004\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\003\000\001\000\004\000\000\000\001\000\000\000\002\000\
\000\000\003\000\001\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\048\000\000\000\003\000\000\000\
\002\000\000\000\000\000\000\000\010\000\000\000\000\000\000\000\
\012\000\000\000\000\000\000\000\000\000\007\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\
\000\000\000\000\000\000\043\000\000\000\044\000\045\000\046\000\
\000\000\000\000\000\000\035\000\000\000\000\000\000\000\000\000\
\000\000\008\000\014\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\019\000\020\000\
\000\000\000\000\000\000\017\000\000\000\040\000\000\000\000\000\
\000\000\000\000\034\000\000\000\000\000\000\000\031\000\032\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\005\000\
\000\000\021\000\000\000\023\000\036\000\016\000\000\000\022\000\
\042\000\000\000\000\000\018\000\015\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\019\000\054\000\020\000\011\000\029\000\
\013\000\030\000\047\000\055\000\044\000\078\000"

let yysindex = "\002\000\
\001\000\000\000\000\000\242\254\000\000\001\000\000\000\016\255\
\000\000\006\255\013\255\040\255\000\000\034\255\006\255\033\255\
\000\000\056\255\033\255\005\255\233\254\000\000\000\255\217\255\
\005\255\217\255\217\255\057\255\063\255\005\255\000\000\217\255\
\217\255\217\255\217\255\000\000\012\255\000\000\000\000\000\000\
\217\255\217\255\227\255\000\000\072\255\073\000\059\255\209\255\
\217\255\000\000\000\000\236\255\038\000\025\000\061\255\251\255\
\217\255\217\255\024\255\062\000\005\255\217\255\217\255\217\255\
\217\255\217\255\217\255\217\255\217\255\217\255\000\000\000\000\
\005\255\066\255\062\255\000\000\217\255\000\000\078\255\085\255\
\073\255\010\000\000\000\096\255\024\255\024\255\000\000\000\000\
\046\255\046\255\046\255\046\255\046\255\075\255\084\255\000\000\
\025\000\000\000\217\255\000\000\000\000\000\000\005\255\000\000\
\000\000\050\000\090\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\086\255\
\000\000\092\255\000\000\000\000\000\000\000\000\092\255\014\255\
\000\000\000\000\014\255\000\000\000\000\000\000\000\000\000\000\
\000\000\099\255\000\000\000\000\000\000\255\254\000\000\000\000\
\000\000\101\255\000\000\000\000\051\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\103\255\000\000\000\000\
\101\255\000\000\000\000\000\000\000\000\105\255\000\000\000\000\
\101\255\000\000\074\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\093\255\112\255\000\000\000\000\
\127\255\142\255\157\255\172\255\187\255\000\000\000\000\000\000\
\105\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\133\000\000\000\000\000\000\000\243\255\122\000\000\000\231\255\
\128\000\000\000\000\000\232\255\000\000\047\000"

let yytablesize = 351
let yytable = "\045\000\
\003\000\031\000\001\000\032\000\051\000\033\000\023\000\013\000\
\008\000\013\000\043\000\024\000\046\000\048\000\025\000\006\000\
\026\000\010\000\052\000\053\000\006\000\056\000\034\000\006\000\
\074\000\006\000\035\000\059\000\060\000\013\000\013\000\012\000\
\081\000\027\000\057\000\084\000\014\000\028\000\058\000\064\000\
\065\000\015\000\006\000\016\000\082\000\018\000\006\000\094\000\
\085\000\086\000\087\000\088\000\089\000\090\000\091\000\092\000\
\093\000\021\000\047\000\062\000\063\000\064\000\065\000\097\000\
\047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
\047\000\050\000\047\000\047\000\047\000\107\000\047\000\049\000\
\047\000\033\000\071\000\072\000\079\000\106\000\096\000\033\000\
\033\000\095\000\099\000\033\000\033\000\033\000\033\000\033\000\
\100\000\033\000\033\000\033\000\029\000\033\000\098\000\033\000\
\102\000\103\000\029\000\029\000\104\000\009\000\029\000\029\000\
\029\000\029\000\029\000\011\000\029\000\029\000\029\000\030\000\
\029\000\109\000\029\000\037\000\039\000\030\000\030\000\038\000\
\041\000\030\000\030\000\030\000\030\000\030\000\024\000\030\000\
\030\000\030\000\009\000\030\000\022\000\030\000\017\000\105\000\
\024\000\024\000\024\000\024\000\024\000\025\000\024\000\024\000\
\024\000\000\000\024\000\000\000\024\000\000\000\000\000\025\000\
\025\000\025\000\025\000\025\000\027\000\025\000\025\000\025\000\
\000\000\025\000\000\000\025\000\000\000\000\000\027\000\027\000\
\027\000\027\000\027\000\026\000\027\000\027\000\027\000\000\000\
\027\000\000\000\027\000\000\000\000\000\026\000\026\000\026\000\
\026\000\026\000\028\000\026\000\026\000\026\000\000\000\026\000\
\000\000\026\000\000\000\000\000\028\000\028\000\028\000\028\000\
\028\000\000\000\028\000\028\000\028\000\000\000\028\000\000\000\
\028\000\036\000\037\000\038\000\039\000\040\000\062\000\063\000\
\064\000\065\000\066\000\067\000\068\000\069\000\070\000\041\000\
\000\000\000\000\061\000\000\000\000\000\000\000\073\000\042\000\
\062\000\063\000\064\000\065\000\066\000\067\000\068\000\069\000\
\070\000\062\000\063\000\064\000\065\000\066\000\067\000\068\000\
\069\000\070\000\004\000\000\000\000\000\000\000\000\000\075\000\
\062\000\063\000\064\000\065\000\066\000\067\000\068\000\069\000\
\070\000\000\000\000\000\000\000\000\000\000\000\080\000\062\000\
\063\000\064\000\065\000\066\000\067\000\068\000\069\000\070\000\
\000\000\000\000\000\000\000\000\000\000\101\000\062\000\063\000\
\064\000\065\000\066\000\067\000\068\000\069\000\070\000\000\000\
\000\000\000\000\077\000\062\000\063\000\064\000\065\000\066\000\
\067\000\068\000\069\000\070\000\000\000\000\000\076\000\062\000\
\063\000\064\000\065\000\066\000\067\000\068\000\069\000\070\000\
\000\000\000\000\108\000\062\000\063\000\064\000\065\000\066\000\
\067\000\068\000\069\000\070\000\000\000\083\000\062\000\063\000\
\064\000\065\000\066\000\067\000\068\000\069\000\070\000"

let yycheck = "\025\000\
\000\000\025\001\001\000\027\001\030\000\006\001\002\001\009\001\
\023\001\011\001\024\000\007\001\026\000\027\000\010\001\002\001\
\012\001\002\001\032\000\033\000\007\001\035\000\023\001\010\001\
\049\000\012\001\027\001\041\000\042\000\031\001\032\001\026\001\
\057\000\029\001\023\001\061\000\024\001\033\001\027\001\016\001\
\017\001\002\001\029\001\010\001\058\000\013\001\033\001\073\000\
\062\000\063\000\064\000\065\000\066\000\067\000\068\000\069\000\
\070\000\002\001\008\001\014\001\015\001\016\001\017\001\077\000\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\011\001\024\001\025\001\026\001\103\000\028\001\023\001\
\030\001\008\001\011\001\025\001\024\001\099\000\025\001\014\001\
\015\001\024\001\006\001\018\001\019\001\020\001\021\001\022\001\
\024\001\024\001\025\001\026\001\008\001\028\001\025\001\030\001\
\009\001\031\001\014\001\015\001\025\001\024\001\018\001\019\001\
\020\001\021\001\022\001\024\001\024\001\025\001\026\001\008\001\
\028\001\032\001\030\001\025\001\024\001\014\001\015\001\025\001\
\024\001\018\001\019\001\020\001\021\001\022\001\008\001\024\001\
\025\001\026\001\006\000\028\001\019\000\030\001\015\000\097\000\
\018\001\019\001\020\001\021\001\022\001\008\001\024\001\025\001\
\026\001\255\255\028\001\255\255\030\001\255\255\255\255\018\001\
\019\001\020\001\021\001\022\001\008\001\024\001\025\001\026\001\
\255\255\028\001\255\255\030\001\255\255\255\255\018\001\019\001\
\020\001\021\001\022\001\008\001\024\001\025\001\026\001\255\255\
\028\001\255\255\030\001\255\255\255\255\018\001\019\001\020\001\
\021\001\022\001\008\001\024\001\025\001\026\001\255\255\028\001\
\255\255\030\001\255\255\255\255\018\001\019\001\020\001\021\001\
\022\001\255\255\024\001\025\001\026\001\255\255\028\001\255\255\
\030\001\001\001\002\001\003\001\004\001\005\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\015\001\
\255\255\255\255\008\001\255\255\255\255\255\255\030\001\023\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\014\001\015\001\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\002\001\255\255\255\255\255\255\255\255\028\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\255\255\255\255\255\255\255\255\255\255\028\001\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\021\001\022\001\
\255\255\255\255\255\255\255\255\255\255\028\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\255\255\
\255\255\255\255\026\001\014\001\015\001\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\255\255\255\255\025\001\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\021\001\022\001\
\255\255\255\255\025\001\014\001\015\001\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\255\255\024\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001"

let yynames_const = "\
  EOF\000\
  TRUE\000\
  FALSE\000\
  COLONEQUAL\000\
  WHILE\000\
  DO\000\
  DONE\000\
  BEGIN\000\
  END\000\
  RETURN\000\
  VAR\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  EQUALEQUAL\000\
  GREATER\000\
  SMALLER\000\
  GREATEREQUAL\000\
  SMALLEREQUAL\000\
  LPAR\000\
  RPAR\000\
  SEMICOLON\000\
  COMMA\000\
  LBRACKET\000\
  RBRACKET\000\
  IF\000\
  THEN\000\
  ELSE\000\
  ENDIF\000\
  PRINT\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 26 "impparse.mly"
      ( [] )
# 294 "impparse.ml"
               : Impast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'toplevel) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Impast.program) in
    Obj.repr(
# 27 "impparse.mly"
                   ( _1 :: _2 )
# 302 "impparse.ml"
               : Impast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fun_def) in
    Obj.repr(
# 31 "impparse.mly"
          ( Fundef _1 )
# 309 "impparse.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 35 "impparse.mly"
                      ( (_2, Scalar) )
# 316 "impparse.ml"
               : 'var_decl))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    Obj.repr(
# 36 "impparse.mly"
                                             ( (_2, (Array _4)) )
# 324 "impparse.ml"
               : 'var_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "impparse.mly"
  ( [] )
# 330 "impparse.ml"
               : 'opt_var_decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'var_decl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'opt_var_decls) in
    Obj.repr(
# 41 "impparse.mly"
                         ( _1 :: _2 )
# 338 "impparse.ml"
               : 'opt_var_decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'opt_params) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'opt_var_decls) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 46 "impparse.mly"
    ( { f_name = _1 ; params = _3 ; vars = _6 ; body = _7 } )
# 348 "impparse.ml"
               : 'fun_def))
; (fun __caml_parser_env ->
    Obj.repr(
# 50 "impparse.mly"
  ( [] )
# 354 "impparse.ml"
               : 'opt_params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 51 "impparse.mly"
               ( _1 :: _2 )
# 362 "impparse.ml"
               : 'opt_params))
; (fun __caml_parser_env ->
    Obj.repr(
# 55 "impparse.mly"
  ( [] )
# 368 "impparse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 56 "impparse.mly"
                     ( _2 :: _3 )
# 376 "impparse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 60 "impparse.mly"
        ( _1 )
# 383 "impparse.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instrs) in
    Obj.repr(
# 61 "impparse.mly"
               ( Seq (_1, _2) )
# 391 "impparse.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'instrs) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 66 "impparse.mly"
    ( If (_2, _4, _6) )
# 400 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 68 "impparse.mly"
    ( While (_2, _4) )
# 408 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 70 "impparse.mly"
    ( Assign (_1, _3) )
# 416 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 72 "impparse.mly"
    ( ArrayWrite (_1, _3, _6) )
# 425 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 74 "impparse.mly"
    ( _2 )
# 432 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'opt_expr) in
    Obj.repr(
# 76 "impparse.mly"
    ( Return _2 )
# 439 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 78 "impparse.mly"
    ( Iapp (_1, _3) )
# 447 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 80 "impparse.mly"
    ( Print _3 )
# 454 "impparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'opt_exprs) in
    Obj.repr(
# 84 "impparse.mly"
                                 ( App (_1, _3) )
# 462 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 85 "impparse.mly"
                                 ( Binop ("==", _1, _3) )
# 470 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 86 "impparse.mly"
                                 ( Binop (">", _1, _3) )
# 478 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 87 "impparse.mly"
                                 ( Binop (">=", _1, _3) )
# 486 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 88 "impparse.mly"
                                 ( Binop ("<", _1, _3) )
# 494 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 89 "impparse.mly"
                                 ( Binop ("<=", _1, _3) )
# 502 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 90 "impparse.mly"
                                 ( Binop ("+", _1, _3) )
# 510 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 91 "impparse.mly"
                                 ( Binop ("-", _1, _3) )
# 518 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 92 "impparse.mly"
                                 ( Binop ("*", _1, _3) )
# 526 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 93 "impparse.mly"
                                 ( Binop ("/", _1, _3) )
# 534 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 94 "impparse.mly"
                                 ( Monop ("-", _2) )
# 541 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 95 "impparse.mly"
                                 ( _2 )
# 548 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 96 "impparse.mly"
                                 ( _1 )
# 555 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 97 "impparse.mly"
                                 ( ArrayRead (_1, _3) )
# 563 "impparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 101 "impparse.mly"
  ( None )
# 569 "impparse.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 102 "impparse.mly"
                     ( Some _1 )
# 576 "impparse.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 106 "impparse.mly"
  ( [] )
# 582 "impparse.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 107 "impparse.mly"
                           ( _1 :: _2 )
# 590 "impparse.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 111 "impparse.mly"
  ( [] )
# 596 "impparse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 112 "impparse.mly"
                           ( _2 :: _3 )
# 604 "impparse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 116 "impparse.mly"
                 ( Int (_1) )
# 611 "impparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 117 "impparse.mly"
                 ( Bool (true) )
# 617 "impparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 118 "impparse.mly"
                 ( Bool (false) )
# 623 "impparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 119 "impparse.mly"
                 ( String (_1) )
# 630 "impparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 120 "impparse.mly"
                 ( Ident (_1) )
# 637 "impparse.ml"
               : 'atom))
(* Entry program *)
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
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Impast.program)
