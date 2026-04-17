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

exception FiltrageImpossible

let rec filtre_list eqs subst =
  match eqs with
  | [] -> subst
  | (p, t) :: rest ->
      (match p, t with
      | Var x, _ ->
          (* If the variable is already bound, the new term must match the existing bound term *)
          if is_in_dom x subst then
            if image x subst = t then 
              filtre_list rest subst
            else 
              raise FiltrageImpossible
          else
            (* Bind the new variable and continue *)
            filtre_list rest ((x, t) :: subst)
            
      | Term (f, ps), Term (g, ts) ->
          (* Symbols and arity must match to proceed with sub-terms *)
          if f = g && List.length ps = List.length ts then
            filtre_list ((List.combine ps ts) @ rest) subst
          else
            raise FiltrageImpossible
            
      | Term _, Var _ -> 
          raise FiltrageImpossible)

let filtre motif terme = 
  filtre_list [(motif, terme)] []
;;


exception UnificationImpossible

(* Checks if a variable name 'x' appears inside the term 't' *)
let rec occurs x t =
  match t with
  | Var y -> x = y
  | Term (_, ts) -> List.exists (occurs x) ts
;;

(* Helper function processing a list of equations for unification *)
let rec unifie_list eqs subst =
  match eqs with
  | [] -> subst
  | (t1, t2) :: rest ->
      if t1 = t2 then 
        unifie_list rest subst (* Trivial equality, skip *)
      else
        match t1, t2 with
        (* If either side is a variable, try to bind it *)
        | Var x, t | t, Var x ->
            if occurs x t then 
              raise UnificationImpossible
            else
              let new_subst = [(x, t)] in
              (* Apply the new substitution to the remaining equations *)
              let apply_eq (a, b) = (app_subst new_subst a, app_subst new_subst b) in
              let new_rest = List.map apply_eq rest in
              (* Compose the new substitution with the accumulated ones using your comp_subst *)
              unifie_list new_rest (comp_subst new_subst subst)
              
        | Term (f, ts1), Term (g, ts2) ->
            if f = g && List.length ts1 = List.length ts2 then
              unifie_list ((List.combine ts1 ts2) @ rest) subst
            else
              raise UnificationImpossible
;;

let unifie t1 t2 = 
  unifie_list [(t1, t2)] []
;;