open Pcfast ;;

type pcfval =
  | Intval of int
  | Boolval of bool
  | Stringval of string
  | Funval of (pcfval -> pcfval)
;;

let rec printval = function
  | Intval n -> Printf.printf "%d" n
  | Boolval b -> Printf.printf "%s" (if b then "T" else "F")
  | Stringval s -> Printf.printf "\"%s\"" s
  | Funval f -> Printf.printf "<fun>"
;;

type env = string -> pcfval ;;

let init_env id =
  raise (Failure (Printf.sprintf "Unbound ident: %s" id))
;;

(* extends our mathematical environment - function that picks a string and returns a value *)
let extend env x v = fun y -> if y = x then v else env y;;

let rec semant e rho =
  match e with
  | Int n -> Intval n (* we associate each value with all the base values of the expressions - defined in _pcfval_ *)
  | Bool b -> Boolval b
  | String s -> Stringval s
  | Ident v -> rho v
  | App (e1, e2) -> ( (* has to abstract the cases where e1 is function. Else it doesnt work*)
    match semant e1 rho with  (* we should see if the evaluation is a function*)
    | Funval f -> f (semant e2 rho)
    | _ -> raise (Failure "No-function applied to expression error")
    )
  | Monop("-", e) -> (
      match semant e rho with
      | Intval n -> Intval (-n) (* It has to always return to a Domain value - Intval*)
      | _ -> raise (Failure "Minus expression error")
     )
    (* the other options of mono-operator must be done *)
  | Monop (op, _) -> raise (Failure (Printf.sprintf "Unknown unary op: %s" op))
  | Binop (op, e1, e2) -> (
    match (semant e1 rho), (semant e2 rho) with
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
        | _ -> raise (Failure "Unknown operator error")
      )
    | _ -> raise (Failure "No-integer operations error")
  )
  | If (e, e1, e2) -> (
    match semant e rho with 
    | Boolval b -> (
      match b with 
      | true -> semant e1 rho
      | false -> semant e2 rho
    )
    | _ -> raise (Failure "Non-boolean if expression error")
    )
  | Fun (a, e) -> Funval (fun va -> semant e (extend rho a va)) (* return a function v applied to the new extended environment *)
  | Let (x, e1, e2) -> raise (Failure "A completer")
  | Letrec (f, e1, e2) -> let rec rho' x = 
    if x = f then semant e1 rho'
      else rho x
    in
    semant e2 rho'
;;


let eval e = semant e init_env ;;
