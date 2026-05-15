%{
  open Cshast;;
%}

%token EOF
%token <int> INT
%token TRUE FALSE
%token <string> STRING
%token <string> IDENT
%token <string> ATIDENT
%token <string> PATH

%token DEFINE FUN VAR
%token FOR WHILE IF ELSE IN PASS
%token COMMA PIPE ANDAND
%token PLUS MINUS MULT DIV
%token EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%token SEMICOLON SEMISEMI
%token LPAR RPAR LBRACKET RBRACKET LBRA RBRA

%left EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left PLUS MINUS
%left MULT DIV
%left COMMA

%start main
%type <Cshast.expr> main

%%

main:
  | stmt SEMISEMI      { $1 }
  | SEMISEMI main      { $2 }
;

stmt:
  | DEFINE FUN IDENT LPAR param_list RPAR LBRA stmt_seq RBRA
      { EDefFun($3, $5, ESeq($8)) }
  | DEFINE VAR IDENT EQUAL arith_expr
      { EDefVar($3, $5) }
  | FOR LPAR ATIDENT IN LBRACKET arg_list RBRACKET RPAR LBRA stmt_seq RBRA
    { EFor($3, $6, ESeq($10)) }
  | WHILE LPAR pipe_expr RPAR LBRA stmt_seq RBRA
      { EWhile($3, ESeq($6)) }
  | IF LPAR pipe_expr RPAR LBRA stmt_seq RBRA ELSE LBRA stmt_seq RBRA
      { EIf($3, ESeq($6), ESeq($10)) }
  | IF LPAR pipe_expr RPAR LBRA stmt_seq RBRA
      { EIf($3, ESeq($6), ESeq([])) }
  | IDENT EQUAL arith_expr
      { EAssign($1, $3) }
  | PASS
      { EPass }
  | pipe_expr
      { $1 }
;

stmt_seq:
  | stmt SEMICOLON            { [$1] }
  | stmt SEMICOLON stmt_seq   { $1 :: $3 }
;

pipe_expr:
  | pipe_expr PIPE and_expr   { EPipe($1, $3) }
  | and_expr                  { $1 }
;

and_expr:
  | LPAR pipe_expr RPAR ANDAND LPAR pipe_expr RPAR  { EAnd($2, $6) }
  | primary_expr                                     { $1 }
;

primary_expr:
  | IDENT LPAR arg_list RPAR   { EApp($1, $3) }
  | IDENT cmd_args             { ECmd(EIdent($1) :: $2) }
;

cmd_args:
  | /* empty */           { [] }
  | cmd_arg cmd_args      { $1 :: $2 }
;

cmd_arg:
  | ATIDENT   { EVar($1) }
  | STRING    { EString($1) }
  | INT       { EInt($1) }
  | PATH      { EIdent($1) }
  | IDENT     { EIdent($1) }
  | TRUE      { EBool true }
  | FALSE     { EBool false }
;

arith_expr:
  | arith_expr PLUS  arith_expr       { EBinop("+",  $1, $3) }
  | arith_expr MINUS arith_expr       { EBinop("-",  $1, $3) }
  | arith_expr MULT  arith_expr       { EBinop("*",  $1, $3) }
  | arith_expr DIV   arith_expr       { EBinop("#",  $1, $3) }
  | arith_expr EQUAL        arith_expr { EBinop("=",  $1, $3) }
  | arith_expr GREATER      arith_expr { EBinop(">",  $1, $3) }
  | arith_expr SMALLER      arith_expr { EBinop("<",  $1, $3) }
  | arith_expr GREATEREQUAL arith_expr { EBinop(">=", $1, $3) }
  | arith_expr SMALLEREQUAL arith_expr { EBinop("<=", $1, $3) }
  | atom_expr                          { $1 }
;

atom_expr:
  | INT                  { EInt($1) }
  | TRUE                 { EBool true }
  | FALSE                { EBool false }
  | STRING               { EString($1) }
  | ATIDENT              { EVar($1) }
  | IDENT                { EIdent($1) }
  | LPAR arith_expr RPAR { $2 }
;

arg_list:
  | /* empty */                 { [] }
  | arith_expr                  { [$1] }
  | arith_expr COMMA arg_list   { $1 :: $3 }
;

param_list:
  | /* empty */                { [] }
  | IDENT                      { [$1] }
  | IDENT COMMA param_list     { $1 :: $3 }
;
