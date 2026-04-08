type token =
  | INT of (int)
  | IDENT of (string)
  | TRUE
  | FALSE
  | STRING of (string)
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUAL
  | GREATER
  | SMALLER
  | GREATEREQUAL
  | SMALLEREQUAL
  | LPAR
  | RPAR
  | SEMISEMI
  | LET
  | REC
  | IN
  | FUN
  | ARROW
  | IF
  | THEN
  | ELSE

open Parsing;;
let _ = parse_error;;
# 2 "pcfparse.mly"
  open Pcfast;;

  (* Fonction utilitaire pour le sucre syntaxique let f x y z = ...
     devant générer la même chose que let f = fun x -> fun y -> fun z -> ... *)
  let rec mkfun vars e =
    match vars with
    | [] -> e 
    | x :: y -> EFun( x, mkfun y e )
  ;;
# 41 "pcfparse.ml"
let yytransl_const = [|
  259 (* TRUE *);
  260 (* FALSE *);
  262 (* PLUS *);
  263 (* MINUS *);
  264 (* MULT *);
  265 (* DIV *);
  266 (* EQUAL *);
  267 (* GREATER *);
  268 (* SMALLER *);
  269 (* GREATEREQUAL *);
  270 (* SMALLEREQUAL *);
  271 (* LPAR *);
  272 (* RPAR *);
  273 (* SEMISEMI *);
  274 (* LET *);
  275 (* REC *);
  276 (* IN *);
  277 (* FUN *);
  278 (* ARROW *);
  279 (* IF *);
  280 (* THEN *);
  281 (* ELSE *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* IDENT *);
  261 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\005\000\005\000\006\000\006\000\006\000\006\000\006\000\
\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\004\000\007\000\009\000\006\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\001\000\002\000\001\000\001\000\001\000\001\000\003\000\
\000\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\020\000\023\000\021\000\022\000\000\000\000\000\
\000\000\000\000\000\000\027\000\000\000\000\000\000\000\018\000\
\000\000\002\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\019\000\024\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\011\000\012\000\000\000\000\000\000\000\000\000\000\000\
\026\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\
\000\000\000\000\007\000\005\000\000\000\000\000\006\000"

let yydgoto = "\002\000\
\012\000\013\000\014\000\036\000\015\000\016\000"

let yysindex = "\008\000\
\004\255\000\000\000\000\000\000\000\000\000\000\038\255\004\255\
\255\254\009\255\038\255\000\000\251\254\190\255\013\255\000\000\
\253\254\000\000\018\255\021\255\002\255\005\255\000\000\013\255\
\013\255\013\255\013\255\013\255\013\255\013\255\013\255\013\255\
\000\000\000\000\018\255\020\255\035\255\038\255\038\255\250\254\
\250\254\000\000\000\000\027\255\027\255\027\255\027\255\027\255\
\000\000\038\255\018\255\000\000\019\255\025\255\028\255\038\255\
\038\255\038\255\000\000\000\000\026\255\038\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\170\255\056\255\000\000\
\000\000\000\000\037\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\037\255\000\000\000\000\000\000\000\000\072\255\
\088\255\000\000\000\000\104\255\120\255\136\255\152\255\168\255\
\000\000\000\000\037\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\040\000\249\255\181\000\231\255\000\000\037\000"

let yytablesize = 213
let yytable = "\017\000\
\019\000\026\000\027\000\022\000\003\000\004\000\005\000\006\000\
\001\000\049\000\021\000\023\000\034\000\003\000\004\000\005\000\
\006\000\020\000\007\000\035\000\008\000\009\000\037\000\038\000\
\010\000\055\000\011\000\007\000\039\000\050\000\052\000\053\000\
\024\000\025\000\026\000\027\000\051\000\058\000\003\000\004\000\
\005\000\006\000\054\000\056\000\057\000\062\000\025\000\018\000\
\059\000\060\000\061\000\033\000\007\000\000\000\063\000\009\000\
\000\000\000\000\010\000\000\000\011\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\000\000\008\000\
\008\000\000\000\000\000\008\000\000\000\009\000\009\000\008\000\
\008\000\009\000\009\000\009\000\009\000\009\000\000\000\009\000\
\009\000\000\000\000\000\009\000\000\000\010\000\010\000\009\000\
\009\000\010\000\010\000\010\000\010\000\010\000\000\000\010\000\
\010\000\000\000\000\000\010\000\000\000\000\000\000\000\010\000\
\010\000\013\000\013\000\013\000\013\000\013\000\000\000\013\000\
\013\000\000\000\000\000\013\000\000\000\000\000\000\000\013\000\
\013\000\014\000\014\000\014\000\014\000\014\000\000\000\014\000\
\014\000\000\000\000\000\014\000\000\000\000\000\000\000\014\000\
\014\000\015\000\015\000\015\000\015\000\015\000\000\000\015\000\
\015\000\000\000\000\000\015\000\000\000\000\000\000\000\015\000\
\015\000\016\000\016\000\016\000\016\000\016\000\000\000\016\000\
\016\000\000\000\000\000\016\000\000\000\000\000\000\000\016\000\
\016\000\017\000\017\000\017\000\017\000\017\000\000\000\017\000\
\017\000\003\000\003\000\017\000\000\000\003\000\000\000\017\000\
\017\000\003\000\003\000\024\000\025\000\026\000\027\000\028\000\
\029\000\030\000\031\000\032\000\040\000\041\000\042\000\043\000\
\044\000\045\000\046\000\047\000\048\000"

let yycheck = "\007\000\
\002\001\008\001\009\001\011\000\001\001\002\001\003\001\004\001\
\001\000\035\000\002\001\017\001\016\001\001\001\002\001\003\001\
\004\001\019\001\015\001\002\001\017\001\018\001\002\001\022\001\
\021\001\051\000\023\001\015\001\024\001\010\001\038\000\039\000\
\006\001\007\001\008\001\009\001\002\001\010\001\001\001\002\001\
\003\001\004\001\050\000\025\001\020\001\020\001\010\001\008\000\
\056\000\057\000\058\000\015\000\015\001\255\255\062\000\018\001\
\255\255\255\255\021\001\255\255\023\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\006\001\007\001\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\006\001\007\001\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\255\255\255\255\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\255\255\255\255\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\255\255\255\255\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\255\255\255\255\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\255\255\255\255\255\255\024\001\
\025\001\010\001\011\001\012\001\013\001\014\001\255\255\016\001\
\017\001\016\001\017\001\020\001\255\255\020\001\255\255\024\001\
\025\001\024\001\025\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\024\000\025\000\026\000\027\000\
\028\000\029\000\030\000\031\000\032\000"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  EQUAL\000\
  GREATER\000\
  SMALLER\000\
  GREATEREQUAL\000\
  SMALLEREQUAL\000\
  LPAR\000\
  RPAR\000\
  SEMISEMI\000\
  LET\000\
  REC\000\
  IN\000\
  FUN\000\
  ARROW\000\
  IF\000\
  THEN\000\
  ELSE\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 31 "pcfparse.mly"
                      ( _1 )
# 218 "pcfparse.ml"
               : Pcfast.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Pcfast.expr) in
    Obj.repr(
# 32 "pcfparse.mly"
                      ( _2 )
# 225 "pcfparse.ml"
               : Pcfast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 40 "pcfparse.mly"
               ( _1 )
# 232 "pcfparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "pcfparse.mly"
                         ( EFun (_2, _4) )
# 240 "pcfparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'id_list) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "pcfparse.mly"
                                         ( ELet (_2, (mkfun _3 _5), _7) )
# 250 "pcfparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'id_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "pcfparse.mly"
                                                   ( ELetrec (_3, _4, (mkfun _5 _7), _9) )
# 261 "pcfparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "pcfparse.mly"
                                ( EIf (_2, _4, _6) )
# 270 "pcfparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 49 "pcfparse.mly"
             ( _1 )
# 277 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 50 "pcfparse.mly"
                               ( EBinop ("+", _1, _3) )
# 285 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 51 "pcfparse.mly"
                                ( EBinop ("-", _1, _3) )
# 293 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 52 "pcfparse.mly"
                               ( EBinop ("*", _1, _3) )
# 301 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 53 "pcfparse.mly"
                              ( EBinop ("/", _1, _3) )
# 309 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 54 "pcfparse.mly"
                                ( EBinop ("=", _1, _3) )
# 317 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 55 "pcfparse.mly"
                                  ( EBinop (">", _1, _3) )
# 325 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 56 "pcfparse.mly"
                                  ( EBinop ("<", _1, _3) )
# 333 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 57 "pcfparse.mly"
                                       ( EBinop (">=", _1, _3) )
# 341 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 58 "pcfparse.mly"
                                       ( EBinop ("<=", _1, _3) )
# 349 "pcfparse.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_expr) in
    Obj.repr(
# 62 "pcfparse.mly"
                ( _1 )
# 356 "pcfparse.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'app_expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'simple_expr) in
    Obj.repr(
# 63 "pcfparse.mly"
                         ( EApp (_1, _2) )
# 364 "pcfparse.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 67 "pcfparse.mly"
                        ( EInt _1 )
# 371 "pcfparse.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 68 "pcfparse.mly"
                        ( EBool true )
# 377 "pcfparse.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "pcfparse.mly"
                        ( EBool false )
# 383 "pcfparse.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 70 "pcfparse.mly"
                        ( EIdent _1 )
# 390 "pcfparse.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 71 "pcfparse.mly"
                        ( _2 )
# 397 "pcfparse.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "pcfparse.mly"
    ( [] )
# 403 "pcfparse.ml"
               : 'id_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'id_list) in
    Obj.repr(
# 76 "pcfparse.mly"
                  ( _1 :: _2 )
# 411 "pcfparse.ml"
               : 'id_list))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Pcfast.expr)
