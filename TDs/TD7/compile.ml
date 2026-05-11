exception Compilation_not_implemented ;;
exception Unbound_identifier of string ;;

let rec find_pos list x =
    let rec find_pos_aux l x pos = (match l with 
    | a::q -> if x = a then pos
              else find_pos_aux q x pos+1
    | [] -> raise (Failure "Unknown List index"))
in find_pos_aux list x 0 ;;


(* Generate bytecode for a general expression. *)
let rec compile_expr rho = function
  | Pcfast.Bool b -> [VmBytecode.VMI_Loadb b]
  | Pcfast.Int i -> [VmBytecode.VMI_Loadi i]
  | Pcfast.String s -> [VmBytecode.VMI_Loads s]
  | Pcfast.If (e1, e2, e3) -> [VmBytecode.VMI_Push] @ (compile_expr rho e1) @ [VmBytecode.VMI_Branch ((compile_expr rho e2), (compile_expr rho e3))]
  | Pcfast.Ident id -> 
    let pos = find_pos rho id in [VmBytecode.VMI_Access pos]
  
  | Pcfast.Monop (o_name, e) -> ( match o_name with
      | "-" -> (match e with
        | Pcfast.Int i -> [VmBytecode.VMI_Loadi (-i)]
        | _ -> raise (Failure "Monop to non-number error")
        ) 
    | _ -> raise (Failure "Unknown Monop")
  )
  | Pcfast.Binop (o_name, e1, e2) -> ( (* the code in the Accumulator is still necessary to calculate in compile of C1, so it is necessary to save the values from the Accumulator from before using a first Push*)
    let operation_values = [VmBytecode.VMI_Push (* old stack *)] @ (compile_expr rho e2) @ [VmBytecode.VMI_Swap (*old stack used in compile 1*)]@ (compile_expr rho e1) in
    match o_name with (* attention to the type of path that each operation does: (n, Plus :: c, m :: p) => (n + m, c, p)*)
        | "+" -> operation_values @ [VmBytecode.VMI_Plus] 
        | "-" -> operation_values @ [VmBytecode.VMI_Sub]
        | "*" -> operation_values @ [VmBytecode.VMI_Mult]
        | "/" -> operation_values @ [VmBytecode.VMI_Div]
        | _ -> raise (Failure "Unknown Binop")
    )
  | Pcfast.Fun (x, body) -> 
    let new_rho = x::rho in 
    [VmBytecode.VMI_Mkclos (compile_expr new_rho body)]
    
  | Pcfast.App (e1, e2) -> [VmBytecode.VMI_Push] @ (compile_expr rho e1) @ [VmBytecode.VMI_Swap] @ (compile_expr rho e2) @ [VmBytecode.VMI_Apply] 
  | Pcfast.Let (x, e1, e2) ->
    let fun_x_e2 = Pcfast.Fun (x, e2) in
    let apply_fun_in_e1 = Pcfast.App (fun_x_e2, e1) in
    (compile_expr rho apply_fun_in_e1)
  | _ -> raise Compilation_not_implemented
;;
