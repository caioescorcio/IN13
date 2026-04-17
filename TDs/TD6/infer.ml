(* Recherche du type d'un identificateur dans un environment. *)
let rec find_id_sch idname env = match env with
    | [] -> raise (Types.Error("Error finding the ID"))
    | (x, ty)::next -> 
        if x = idname then ty
        else find_id_sch idname next
;;


(* Inference du type d'une expression. *)
let rec infer env = function
  | Pcfast.Int _ -> (Types.TInt, Subst.empty)
  | Pcfast.Bool _ -> (Types.TBool, Subst.empty)
  | Pcfast.String _ -> (Types.TString, Subst.empty)
  | Pcfast.Ident v -> (Types.instance (find_id_sch v env), Subst.empty) (* we find the corresponding type at the environment and we make a substitution in all the previous instances*)
  | Pcfast.If (cond_e, then_e, else_e) -> (
        let (t1, s1) = infer env cond_e in 
        let s1p = Unify.unify t1 Types.TBool in
        let (t2, s2) = infer (Subst.subst_env (Subst.compose s1 s1p) env) then_e in
        let (t3, s3) = infer (Subst.subst_env (Subst.compose (Subst.compose s1 s1p) s2) env) else_e in
        (* then unify to get the same type *)
        let s4 = Unify.unify (Subst.apply t2 s3) t3 in (* t2 in the same context of t3*)
        (Subst.apply t3 s4, Subst.compose (Subst.compose (Subst.compose (Subst.compose s1 s1p) s2) s3) s4) (* composing all the previous associations with what is already done*)
            
    )

  | Pcfast.Fun (arg_name, body) ->
      raise (Failure "A compl�ter : infer")
  | Pcfast.Let (v_name, e1, e2) ->
      raise (Failure "A compl�ter : infer")
  | Pcfast.Letrec (v_name, e1, e2) ->
      raise (Failure "A compl�ter : infer")
  | Pcfast.App (e1, e2) ->
      raise (Failure "A compl�ter : infer")
  | Pcfast.Binop (o_name, e1, e2) -> (
      match o_name with
      | "+" | "-" | "/" | "*" ->
          raise (Failure "A compl�ter : infer")
      | "=" | ">" | ">=" | "<" | "<=" ->
          raise (Failure "A compl�ter : infer")
      | _ -> failwith "Unknown binop"
     )
  | Pcfast.Monop (o_name, e) -> (
      match o_name with
      | "-" ->
          raise (Failure "A compl�ter : infer")
      | _ -> failwith "Unknown monop"
     )
;;
