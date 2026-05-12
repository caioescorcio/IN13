

type expr =
  | EInt of int                                 (* 1, 2, 3 *)
  | EBool of bool                               (* true, false *)
  | EString of string                           (* "hello" *)
  | EIdent of string                            (* x, toto, fact *)
  | EApp of (expr * expr)                       (* application e1 e2 *)
  | EMonop of (string * expr)                   (* -e *)
  | EBinop of (string * expr * expr)            (* e1 + e2 *)
  | EIf of (expr * expr * expr)                 (* if e1 then e2 else e3 *)
  | EFun of (string * expr)                     (* fun v -> e *)
  | ELet of (string * expr * expr)              (* let x = e1 in e2 *)
;;



let params_body e =
  let rec un_body params expr = match expr with
  | EFun( p, e) -> un_body (p::params) e
  | e -> (List.rev params, e) in
  un_body [] e
;;


let rec print oc = function
  | EInt n -> Printf.fprintf oc "%d" n
  | EBool b -> Printf.fprintf oc "%s" (if b then "true" else "false")
  | EIdent s -> Printf.fprintf oc "%s" s
  | EString s -> Printf.fprintf oc "\"%s\"" s
  | EApp (e1, e2) -> Printf.fprintf oc "(%a %a)" print e1 print e2
  | ELet (f, e1, e2) ->
      let (params, e) = params_body e1 in
      Printf.fprintf oc "(let %s %a= %a in %a)"
        f
        (fun oc -> List.iter (fun s -> Printf.fprintf oc "%s " s)) params
        print e
        print e2

  | EFun (x, e) -> Printf.fprintf oc "(fun %s -> %a)"  x print e
  | EIf (test, e1, e2) ->
      Printf.fprintf oc "(if %a then %a else %a)" print test print e1 print e2
  | EBinop (op,e1,e2) ->
      Printf.fprintf oc "(%a %s %a)" print e1 op print e2
  | EMonop (op,e) -> Printf.fprintf oc "%s%a" op print e
;;
