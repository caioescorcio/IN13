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

    (* 
    First, I will have the substitution for the "type" saw with arg_name for this, you should make a new "first type", that will be solved later when having all the substitutions
        
    when doing the type, you should also create the schema to describe an ensemble of types that are going to be associated to the type
    
    Now we extend the env by saying that there will be a new association between the ensemble of types with "arg_name"
    
    then with the new env, we can check the type of the body > Apply the body susbstitution for the previous "abstract" type of arg_name and return it as a type_fun and the ensemble of substitutions
    *)
  | Pcfast.Fun (arg_name, body) -> (
    let arg_ty = Types.new_ty_var () in (* as body can be any type of var, we have to create a new type for it, abstract*)
    let arg_sch = Types.trivial_sch arg_ty in   (* so, we create a schema abstract to make it accessible in our env *)
    let new_env = ((arg_name, arg_sch) :: env) in
    let (body_ty, body_s) = infer new_env body in
    let t_result = Types.TFun ((Subst.apply arg_ty body_s), body_ty) in
    (t_result, body_s)
    )

    (* for the let, like in 
        let x = 4 ;;
    x must have the same type of e1, so firstly we make the inference, then we get the new env with the 
    x values associated. After that, we generalize the type of e1 in our new env to get the schema
    (to say that everytime that x appears it can have the schema of e1 in its generalisation (before the substituition, beacause of this we have to generalize))
    then we can add the association between v_name and the e1's schema. 
    *)
  | Pcfast.Let (v_name, e1, e2) ->
      let (t1, s1) = infer env e1 in 
      let new_env = (Subst.subst_env s1 env) in
      let t1_sch = (Types.generalize t1 new_env) in
      let new_env' = ((v_name, t1_sch) :: new_env) in 
      let (t2, s2) = infer new_env' e2 in
      (t2, Subst.compose s2 s1) 


      (* let rec must firstly define a "temp" type for v_name to use it as the same t1/t2 types *)
      (* when created a temp type, it means that in e1 (the recursive part) everytime that v_name appears it should be calculated in an env with the previous type.
      Then, after knowing the best e1 fit, we can update t1 with the respective v_name unifying them:
              v_name      e1 = v_name
      let rec f = ... ... f k .. 
      in unifying them, we have to still substitute each t1 by the ensembled t1+v_name to calculate the new env (new_env2) with the right e1
      finally we can really associate v_name with the right "generalization" of t1 in this env.
      the rest goes with the implementation of the subs of e1 in the given "updated" env with both v_name and e1 equals and associated.
      
      *)
  | Pcfast.Letrec (v_name, e1, e2) ->
        let tmp_v_ty = Types.new_ty_var () in
        let tmp_v_ty_sch = Types.trivial_sch tmp_v_ty in 
        let new_env = (v_name, tmp_v_ty_sch) :: env in 
        let (t1, s1) = infer new_env e1 in 
        let unify_v_ty_t1 = Unify.unify t1 tmp_v_ty in 
        let t1' = Subst.apply t1 unify_v_ty_t1 in
        let final_t1_subs = (Subst.compose unify_v_ty_t1 s1) in 
        let new_env2 = Subst.subst_env final_t1_subs env in
        let new_env3 = (v_name, (Types.generalize t1' new_env2)) :: new_env2 in
        let (t2, s2) = infer new_env3 e2 in
        (t2, Subst.compose s2 final_t1_subs)
  | Pcfast.App (e1, e2) ->
      let (t1, s1) = infer env e1 in 
      let (t2, s2) = infer (Subst.subst_env s1 env) e2 in (* e1 should be the type t1 -> t2 *)
      let t1' = (Subst.apply t1 s2) in (* now we have the t1 in an env where we have the subst from e2 *)
      let tmp_t1' = Types.new_ty_var () in (* we have to unify the expression from t1' (TFun) with the new t1. for this we need to make a "fake" TFun to say that we can associate t1 with it*)
      let t_fun_with_t2 =  (Types.TFun (t2, tmp_t1')) in
      let expression_types_subs = Unify.unify t1' t_fun_with_t2 in (*unify t1' with TFun*)
      (* now we reapply the subs made with e1 with our ancient tmp_t1'*)
      (Subst.apply tmp_t1' expression_types_subs, (Subst.compose expression_types_subs (Subst.compose s2 s1))) 
  | Pcfast.Binop (o_name, e1, e2) -> (
      match o_name with
      | "+" | "-" | "/" | "*" ->
        let (t1, s1) = infer env e1 in 
        let (t2, s2) = infer (Subst.subst_env s1 env) e2 in
        let expression_types_subs = Unify.unify t1 t2 in (* the substitution that unifies t1 and t2*)
        let verified_e1_type = Subst.apply t1 expression_types_subs in  (* now we see the true type of e1*)
        let final_type_subs = Unify.unify verified_e1_type Types.TInt in (* the type HAS to be int*)
        (TInt, (Subst.compose final_type_subs (Subst.compose expression_types_subs (Subst.compose s2 s1))))
      | "=" | ">" | ">=" | "<" | "<=" ->
        let (t1, s1) = infer env e1 in 
        let (t2, s2) = infer (Subst.subst_env s1 env) e2 in
        let expression_types_subs = Unify.unify t1 t2 in  (* it should return a bool at the end with the given subs*) 
        (TBool, (Subst.compose expression_types_subs (Subst.compose s2 s1)))
      | _ -> failwith "Unknown binop"
     )
  | Pcfast.Monop (o_name, e) -> (
      match o_name with
      | "-" ->
          let (t1, s1) = infer env e in
          let expression_types_subs = Unify.unify t1 Types.TInt in
          (TInt, Subst.compose expression_types_subs s1)
      | _ -> failwith "Unknown monop"
     )
;;
