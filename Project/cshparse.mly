%{
  open Cshast;;

  (* Fonction utilitaire pour le sucre syntaxique let f x y z = ...
     devant générer la même chose que let f = fun x -> fun y -> fun z -> ... *)
  let rec mkfun vars e =
    match vars with
    | [] -> e 
    | x :: y -> EFun( x, mkfun y e )
  ;;
%}

%token EOF
%token <int> INT
%token TRUE FALSE
%token <string> STRING

%token <string> IDENT

%token DEFINE FUNCTION VAR
%token IF THEN ELSE
%token PASS
%token COMMA
%token PIPE

%token PLUS MINUS MULT DIV EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL

%token SEMICOLON

%token LPAR RPAR 
%token LBRACKET RBRACKET

%token FROM TO

%token LBRA RBRA
%token SEMISEMI

%token FOR WHILE IN FUN 

%left EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left PLUS MINUS
%left MULT DIV
%left SEMICOLON

%start main
%type <Cshast.expr> main

%%

main: phrase SEMISEMI   { $1 }
    | SEMISEMI main   { $2 }
;


phrase:
  | expr {$1}
  ;

expr:
  | IDENT args { EIdent($1) }
  | expr SEMICOLON args { $1 }
  ;
args:
  | IDENT args {EIdent ($1) :: $2}
  | {[]}
  ;

/*
  | arith_expr { $1 }
  | DEFINE FUN LPAR seqident RPAR LBRA expr RBRA { EFun ($4, $7) }
  | DEFINE VAR seqident EQUAL expr { EDefvar () }
  | DEFINE seqident EQUAL expr { EDef ()}
  | FOR LPAR IDENT IN LBRACKET id_list RBRACKET LBRA expr RBRA { EFor ()}
  | WHILE LPAR expr RPAR LBRA expr RBRA { EWhile ()}
  | IF LPAR expr RPAR LBRA expr RBRA ELSE LBRA expr RBRA { EIf ($2, $4, $6) }
  
  
  |  IDENT id_list EQUAL expr IN expr { ELet ($2, (mkfun $3 $5), $7) }
  | FUN IDENT ARROW expr { EFun ($2, $4) }
  | LET REC IDENT IDENT id_list EQUAL expr IN expr { ELetrec ($3, $4, (mkfun $5 $7), $9) }
;



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
  | app_expr simple_expr { EApp ($1, $2) }  /* priority only occurs in parenthesis or else it is just put
;

simple_expr:
  | INT                 { EInt $1 }
  | TRUE                { EBool true }
  | FALSE               { EBool false }
  | IDENT               { EIdent $1 }
  | LPAR expr RPAR      { $2 }
;


opt_expr:
| { None }
| expr               { Some $1 }
;

opt_exprs:
| { [] }
| expr SEMICOLON exprs               { $1 :: $3 }
;

// if (EXPR) { expression; expression; } 

// ex;

// ex; a; b;




exprs:
| { [] }
| expr SEMICOLON exprs         { $1 :: $3 }
;



// define x, y = [a, b, c];
// define x = [a];
// define x = [];
// define x = 3; 
// define x, y = 3;



opt_array_decls:
| { [] }
| array_decl COMMA opt_var_decls { $1 :: $3 }
;

array_decl:
| DEFINE opt_params EQUAL LBRACKET expr RBRACKET SEMICOLON { ($2, (Array $5)) }
;


opt_params:
| IDENT params { $1 :: $2 }
;

params:
| { [] }
| COMMA IDENT params { $2 :: $3 }
;*/