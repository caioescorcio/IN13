
type expr =
  | EInt of int
  | EBool of bool
  | EString of string
  | EIdent of string           (* bare identifier or path *)
  | EVar of string             (* @x *)
  | EApp of (string * expr list)   (* f(args) *)
  | EBinop of (string * expr * expr)
  | EMonop of (string * expr)
  | ECmd of (expr list)        (* command: name + args *)
  | EPipe of (expr * expr)     (* e1 | e2 *)
  | EAnd of (expr * expr)      (* (e1) && (e2) *)
  | ESeq of (expr list)        (* { s1; s2; ... } *)
  | EAssign of (string * expr)
  | EDefVar of (string * expr)
  | EDefFun of (string * string list * expr)
  | EFor of (string * expr list * expr)   (* var, values, body *)
  | EWhile of (expr * expr)
  | EIf of (expr * expr * expr)
  | EPass
;;

let rec print oc = function
  | EInt n -> Printf.fprintf oc "%d" n
  | EBool b -> Printf.fprintf oc "%s" (if b then "true" else "false")
  | EString s -> Printf.fprintf oc "\"%s\"" s
  | EIdent s -> Printf.fprintf oc "%s" s
  | EVar s -> Printf.fprintf oc "@%s" s
  | EApp (f, args) ->
      Printf.fprintf oc "%s(" f;
      List.iteri (fun i e ->
        if i > 0 then Printf.fprintf oc ", ";
        print oc e) args;
      Printf.fprintf oc ")"
  | EBinop (op, e1, e2) ->
      Printf.fprintf oc "(%a %s %a)" print e1 op print e2
  | EMonop (op, e) ->
      Printf.fprintf oc "%s%a" op print e
  | ECmd es ->
      Printf.fprintf oc "CMD[";
      List.iteri (fun i e ->
        if i > 0 then Printf.fprintf oc " ";
        print oc e) es;
      Printf.fprintf oc "]"
  | EPipe (e1, e2) ->
      Printf.fprintf oc "(%a | %a)" print e1 print e2
  | EAnd (e1, e2) ->
      Printf.fprintf oc "(%a && %a)" print e1 print e2
  | ESeq es ->
      Printf.fprintf oc "{ ";
      List.iteri (fun i e ->
        if i > 0 then Printf.fprintf oc "; ";
        print oc e) es;
      Printf.fprintf oc " }"
  | EAssign (x, e) ->
      Printf.fprintf oc "%s = %a" x print e
  | EDefVar (x, e) ->
      Printf.fprintf oc "define var %s = %a" x print e
  | EDefFun (f, ps, body) ->
      Printf.fprintf oc "define function %s(%s) %a"
        f (String.concat ", " ps) print body
  | EFor (x, values, body) ->
    let print_expr_list oc es =
      List.iteri (fun i e ->
        if i > 0 then Printf.fprintf oc ", ";
        print oc e
      ) es
    in
    Printf.fprintf oc "for @%s in [%a] %a"
      x print_expr_list values print body
  | EWhile (cond, body) ->
      Printf.fprintf oc "while (%a) %a" print cond print body
  | EIf (cond, t, f) ->
      Printf.fprintf oc "if (%a) %a else %a" print cond print t print f
  | EPass ->
      Printf.fprintf oc "pass"
;;
