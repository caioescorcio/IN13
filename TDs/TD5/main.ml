(* bash:
*   rlwrap ocaml
*   # use "main.ml"
*
*
*
*
*
*
*
*
*
*)

type term =
    | Var of string
    | Term of string * term list


let zero = Term ("Zero", [ ]) ;;
let succ t = Term ("Succ", [t]) ;;
let plus (t1,t2) = Term ("Plus", [t1; t2]) ;;
let x = Var "x" and y = Var "y" and z = Var "z" ;;

plus (succ zero, plus (zero, succ zero)) ;;

let rec vars_term accu t = 
    match t with 
    | Var x -> x :: accu
    | Term (_, ts) -> vars_term_list accu ts
    
    and (* multually recursive function *)
    
    vars_term_list accu l =
    match l with
    | [] -> accu
    | x_0::x_1 -> let new_accu = (vars_term accu x_0) in
    vars_term_list new_accu x_1
;;

let vars t = 
    vars_term [] t ;;
    
    
let rec image x theta = match theta with
    | [] -> Var x
    | (v, t)::next -> 
        if v = x then t
        else image x next
    ;;
    
let rec app_subst theta t = match t with 
    | Var x -> image x theta
    | Term (s, ts) -> Term (s, (List.map (app_subst theta) ts))
;;

type subst = (string * term) list 

let rec is_in_dom x l = match l with
    | [] -> false
    | (a, _)::q -> 
        if x = a then true
        else is_in_dom x q
;;

let rec diff theta_2 theta_1 = match theta_2 with
    | [] -> []
    | (x, v)::others ->
        if is_in_dom x theta_1 then 
            diff others theta_1 
        else (x, v)::(diff others theta_1)
;;


let comp_subst theta_2 theta_1 = 
    let theta_2_minus_theta_1 = diff theta_2 theta_1 in
    let theta2_applied_to_theta_1 = List.map (fun (v, t) -> (v, app_subst theta_2 t)) theta_1 in
    theta2_applied_to_theta_1 @ theta_2_minus_theta_1
;;


    
