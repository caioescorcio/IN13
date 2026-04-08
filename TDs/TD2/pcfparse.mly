%{
  open Pcfast;;

  (* Fonction utilitaire pour le sucre syntaxique let f x y z = ...
     devant générer la même chose que let f = fun x -> fun y -> fun z -> ... *)
  let rec mkfun vars e =
    match vars with
    | [] -> e 
    | x :: y -> EFun( x, mkfun y e )
  ;;
%}

%token <int> INT
%token <string> IDENT
%token TRUE FALSE
%token <string> STRING
%token PLUS MINUS MULT DIV EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%token LPAR RPAR SEMISEMI
%token LET REC IN FUN ARROW
%token IF THEN ELSE

%left EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left PLUS MINUS
%left MULT DIV

%start main
%type <Pcfast.expr> main

%%

main: expr SEMISEMI   { $1 }
    | SEMISEMI main   { $2 }
;


/* Grammaire ci-dessous a finir */


expr:
  | arith_expr { $1 }
  | FUN IDENT ARROW expr { EFun ($2, $4) }
  | LET IDENT id_list EQUAL expr IN expr { ELet ($2, (mkfun $3 $5), $7) }
  | LET REC IDENT IDENT id_list EQUAL expr IN expr { ELetrec ($3, $4, (mkfun $5 $7), $9) }
  | IF expr THEN expr ELSE expr { EIf ($2, $4, $6) }
;

/* all the arihtimetic expressions*/
arith_expr:
  | app_expr { $1 }
  | arith_expr PLUS arith_expr { EBinop ("+", $1, $3) }
  | arith_expr MINUS arith_expr { EBinop ("-", $1, $3) }
  | arith_expr MULT arith_expr { EBinop ("*", $1, $3) }
  | arith_expr DIV arith_expr { EBinop ("/", $1, $3) }
  | arith_expr EQUAL arith_expr { EBinop ("=", $1, $3) }
  | arith_expr GREATER arith_expr { EBinop (">", $1, $3) }
  | arith_expr SMALLER arith_expr { EBinop ("<", $1, $3) }
  | arith_expr GREATEREQUAL arith_expr { EBinop (">=", $1, $3) }
  | arith_expr SMALLEREQUAL arith_expr { EBinop ("<=", $1, $3) }
;

app_expr:
  | simple_expr { $1 }
  | app_expr simple_expr { EApp ($1, $2) }  /* priority only occurs in parenthesis or else it is just put*/
;

simple_expr:    /* atomic expressions that are terminal (ALL THAT IS FINAL IS TERMINAL)*/
  | INT                 { EInt $1 }
  | TRUE                { EBool true }
  | FALSE               { EBool false }
  | IDENT               { EIdent $1 }
  | LPAR expr RPAR      { $2 }
;

id_list:
  | { [] }  /* optional ident */
  | IDENT id_list { $1 :: $2 }
;