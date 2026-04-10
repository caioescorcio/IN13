open Pcfast;;

type pcfval =
  | Intval of int
  | Boolval of bool
  | Stringval of string
  | Funval of { param: string; body: expr; env: environment }
  | Funrecval of { fname: string; param: string; body: expr; env: environment }
  (* | Coupleval of { left: pcfval; right: pcfval } *)
  (* The atomic values - before the compiler  *)

and environment = (string * pcfval) list  
(* this time the envorinment is not an OCaml function but a list. Before = List + List.assoc
Now they are 2 different functions: env = List and lookup = List.assoc *)
;;

let rec printval = function
  | Intval n -> Printf.printf "%d" n
  | Boolval b -> Printf.printf "%s" (if b then "true" else "false")
  | Stringval s -> Printf.printf "%S" s
  | Funval _ -> Printf.printf "<fun>"
  | Funrecval _ -> Printf.printf "<fun rec>"
;;

(* Environnement. *)
let init_env = [] ;;

let error msg = raise(Failure msg) ;; (* error function *)

let extend rho x v = (x, v) :: rho ;; (* list extension *)

(* Once the environment is a list, the lookup is used as an association between the variable names and the environment*)
let lookup var_name rho =
  try List.assoc var_name rho
  with Not_found -> error (Printf.sprintf "Undefined ident '%s'" var_name)
;;


(* Fonction "bouche-trou". *)
let afinir () = Stringval "A FINIR" ;;

(* Same as before, we associate each token/label to its evaluation*)

let rec eval e rho =
  match e with
  | EInt n -> Intval n
  | EBool b -> Boolval b
  | EString s -> Stringval s
  | EIdent v -> lookup v rho (* association between the new "values list" of the environment -- before it was a  function to associate each value *)
  | EApp (e1, e2) -> (
    match eval e1 rho with 
    | Funval f -> let v2 = eval e2 rho in 
      let rho_0 = f.env in
      let e_0 = f.body in
      let x = f.param in
      eval e_0 (extend rho_0 x v2) 
    | Funrecval fr as fval -> let v2 = eval e2 rho in (* using let-in to simplify the names, it is like the slides*)
      let f = fr.fname in
      let rho_0 = fr.env in
      let e_0 = fr.body in
      let x = fr.param in
      eval e_0 (extend (extend rho_0 f fval) x v2)
    | _ -> error "Application of a non valid function"
  )
  | EMonop ("-", e) -> ( 
    match eval e rho with
    | Intval n -> Intval (-n)
    | _ -> error "Negative non-number expression"
  )
  | EMonop (op, _) ->
      error (Printf.sprintf "Unknown unary op: %s" op)
  | EBinop (op, e1, e2) -> (
    match (eval e1 rho), (eval e2 rho) with
      | Intval a, Intval b -> (
        match op with 
        | "*" -> Intval (a * b)
        | "-" -> Intval (a - b)
        | "+" -> Intval (a + b)
        | "/" -> Intval (a / b)
        | "<=" -> Boolval (a <= b)
        | "<"  -> Boolval (a < b)
        | ">=" -> Boolval (a >= b)
        | ">"  -> Boolval (a > b)
        | "="  -> Boolval (a = b)
        | _ -> error "Unknown operator error"
      )
      | _ -> error "Invalid operands for operation "
    
  )
  | EIf (e, e1, e2) -> (
    match eval e rho with 
      | Boolval b -> ( 
        match b with
        | true -> eval e1 rho
        | false -> eval e2 rho
      )
      | _ -> error "Non-boolean if expression error"
    )

  | EFun (a, e) -> Funval { param = a; body = e; env = rho }
  | ELet (x, e1, e2) -> (
    let v1 = eval e1 rho in
    eval e2 (extend rho x v1) 
  )
  | ELetrec (f, x, e1, e2) -> eval e2 (extend rho f (Funrecval {fname = f; param = x; body = e1; env = rho}))
;;

let eval e = eval e init_env ;;
