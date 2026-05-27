type value =
  | VInt    of int
  | VBool   of bool
  | VString of string
  | VUnit
  | VClosure of (string list * Cshast.expr * env)

and env = (string * value) list

(* a little remark is that a good amount of the following functions are naturally in the List lib of OCaml. I chose to not use them as imports 
 to make the code more understandable *)

(*linear search through the association list. Returns the first (most recent) binding for key. *)
let rec assoc key = function
  | []                        -> raise Not_found
  | (k, v) :: _ when k = key -> v
  | _ :: rest                 -> assoc key rest

(*same as assoc but returns None instead of raising on missing key. Used by EIdent to fall back to VString when a name is not bound. *)
let rec assoc_opt key = function
  | []                        -> None
  | (k, v) :: _ when k = key -> Some v
  | _ :: rest                 -> assoc_opt key rest

(*builds a new list by applying f to every element. *)
let rec map f = function
  | []      -> []
  | x :: xs -> f x :: map f xs

(*left fold: threads an accumulator through the list left-to-right. Used by ESeq so that each expression receives the env produced by the previous one. *)
let rec fold_left f acc = function
  | []      -> acc
  | x :: xs -> fold_left f (f acc x) xs

(*same as fold_left but consumes two lists in lockstep. Used by EApp to bind each parameter name to its argument value for each occurence. *)
let rec fold_left2 f acc l1 l2 =
  match l1, l2 with
  | [],      []       -> acc
  | x :: xs, y :: ys -> fold_left2 f (f acc x y) xs ys
  | _                 -> raise (Invalid_argument "fold_left2")

(*iterates f over the list*)
let rec iter f = function
  | []      -> ()
  | x :: xs -> f x ; iter f xs

(*converts a list to an array, required by Unix.execvp. Written without Array.of_list since we avoid standard library modules. *)
let to_array lst =
  match lst with
  | [] -> [||]
  | hd :: _ ->
      let rec len acc = function [] -> acc | _ :: t -> len (acc + 1) t in
      let n   = len 0 lst in
      let arr = Array.make n hd in
      let rec fill i = function
        | []      -> ()
        | x :: xs -> arr.(i) <- x ; fill (i + 1) xs
      in
      fill 0 lst ; arr


(*converts a runtime value to a string for use as a command argument*)
let value_to_string = function
  | VInt n      -> string_of_int n
  | VBool b     -> if b then "true" else "false"
  | VString s   -> s
  | VUnit       -> ""
  | VClosure _  -> failwith "cannot use a function as a string"

(* decides whether a value is "truth" for conditionals and && *)
let is_truth = function
  | VBool b    -> b
  | VInt n     -> n <> 0
  | VString s  -> s <> ""
  | VUnit      -> false
  | VClosure _ -> true

(*variable lookup*)
let lookup x env =
  try assoc x env
  with Not_found -> failwith ("Unbound variable: " ^ x)

(* extends the environment  *)
let bind x v env = (x, v) :: env

let rec eval e env =
  match e with
  | Cshast.EInt n    -> (VInt n, env)
  | Cshast.EBool b   -> (VBool b, env)
  | Cshast.EString s -> (VString s, env)
  | Cshast.EPass  -> (VUnit, env)
  (* if the name is bound in env, return its value. otherwise fall back to VString so "ls", "-la", "/tmp" etc. work as command tokens without needing quotes. *)
  | Cshast.EIdent s  ->
      (match assoc_opt s env with
       | Some v -> (v, env)
       | None   -> (VString s, env))
  | Cshast.EVar s -> (lookup s env, env)
  (* ESeq threads the environment left-to-right so that a define/assign in position i is visible to expressions at positions i+1 .. n. *)
  | Cshast.ESeq [] -> (VUnit, env)
  | Cshast.ESeq es ->
      (*step: discard the previous value, keep the updated env*)
      let step (_, acc_env) e = eval e acc_env in
      fold_left step (VUnit, env) es

  (*variable binding*)
  | Cshast.EDefVar (x, e) ->
      let (v, env') = eval e env in
      (VUnit, bind x v env')
  | Cshast.EAssign (x, e) ->
      let (v, env') = eval e env in
      (VUnit, bind x v env')

  | Cshast.EDefFun (f, params, body) ->
      (VUnit, bind f (VClosure (params, body, env)) env)

  (*  Function call 
     looks up f to get its closure (params, body, closure_env). After this it evaluates each argument in the caller's env.
     then binds the params -> values in closure_env (not caller's env) and finally body in that call_env; discard any env changes (local scope). *)
  | Cshast.EApp (f, args) ->
      (match lookup f env with
       | VClosure (params, body, closure_env) ->
           let eval_arg a = fst (eval a env) in (* gets the evaluation of each argument in env - Ex: f(x){} -> f(4) -> VInt 4 -> env += ["x", VInt 4] *)
           let bind_param new_env param value = bind param value new_env in
           let values = map eval_arg args in (*gets the list of values to be bond to the parameters*)
           let call_env =
             try fold_left2 bind_param closure_env params values (*associates each parameter with the current value to function exec*)
             with Invalid_argument _ ->
               failwith (f ^ ": wrong number of arguments")
           in
           let (v, _) = eval body call_env in
           (v, env)                          (* caller's env is unchanged *)
       | _ -> failwith (f ^ " is not a function"))

  | Cshast.EBinop (op, e1, e2) -> eval_binop op e1 e2 env
  | Cshast.EMonop (op, e) ->
      let (v, env') = eval e env in
      let result = match op, v with
        | "-", VInt n -> VInt (-n)
        | _ -> failwith ("type error in unary " ^ op)
      in
      (result, env')

  (* external commands and pipes  *)
  | Cshast.ECmd args        -> eval_cmd args env
  | Cshast.EPipe (e1, e2)   -> eval_pipe e1 e2 env

  (* evaluates e2 only when e1 is truthy; propagates env from e1 to e2. *)
  | Cshast.EAnd (e1, e2) ->
      let (v1, env1) = eval e1 env in
      if is_truth v1 then eval e2 env1
      else (VBool false, env1)

  (* evaluates the condition, then exactly one branch.
     The branch's env is propagated to the caller. *)
  | Cshast.EIf (cond, t, f) ->
      let (vc, env1) = eval cond env in
      if is_truth vc then eval t env1 else eval f env1

  (* while env_ref carries sigma across iterations so that assignments inside
     the body (ex: i = @i + 1) are visible in the next condition check. *)
  | Cshast.EWhile (cond, body) ->
      let env_ref = ref env in
      while is_truth (fst (eval cond !env_ref)) do
        let (_, new_env) = eval body !env_ref in
        env_ref := new_env
      done;
      (VUnit, !env_ref)

  (*  binds the loop variable x to each value in turn, inside a fresh extension of env_ref, *)
  (*then propagates the body's resulting env (minus x) back through env_ref for the next iteration. *)
  | Cshast.EFor (x, values, body) ->
      let env_ref = ref env in (* to reuse the env with the "!"*)
      let run_iter v_expr =
        let (v, _)    = eval v_expr !env_ref in (*evaluation of the argument to be looped*)
        let loop_env  = bind x v !env_ref in (* binds x to each value*)
        let (_, new_env) = eval body loop_env in  (*"recalculates" the body for each value*)
        env_ref := new_env (* loop env*)
      in
      iter run_iter values;
      (VUnit, !env_ref)

(* evaluates e1 then e2, threading sigma left-to-right. the result of op is computed from the two runtime values. *)
and eval_binop op e1 e2 env =
  let (v1, env1) = eval e1 env in
  let (v2, env2) = eval e2 env1 in
  let result = match op with
    | "+"  -> (match v1, v2 with
               | VInt a, VInt b    -> VInt (a + b)
               | VString a, VString b -> VString (a ^ b) 
               | VString a, VInt b    -> VString (a ^ string_of_int b) (*cases to string add*)
               | VInt a,    VString b -> VString (string_of_int a ^ b) 
               | _ -> failwith "type error in +")
    | "-"  -> (match v1, v2 with
               | VInt a, VInt b -> VInt (a - b)
               | _ -> failwith "type error in -")
    | "*"  -> (match v1, v2 with
               | VInt a, VInt b -> VInt (a * b)
               | _ -> failwith "type error in *")
    | "#"  -> (match v1, v2 with  (* / is reserved for path tokens, so I'm using # *)
               | VInt a, VInt b ->
                   if b = 0 then failwith "division by zero"
                   else VInt (a / b)
               | _ -> failwith "type error in #")
    | "="  -> VBool (v1 = v2)
    | ">"  -> (match v1, v2 with
               | VInt a,    VInt b    -> VBool (a > b)
               | VString a, VString b -> VBool (a > b)
               | _ -> failwith "type error in >")
    | "<"  -> (match v1, v2 with
               | VInt a,    VInt b    -> VBool (a < b)
               | VString a, VString b -> VBool (a < b)
               | _ -> failwith "type error in <")
    | ">=" -> (match v1, v2 with
               | VInt a,    VInt b    -> VBool (a >= b)
               | VString a, VString b -> VBool (a >= b)
               | _ -> failwith "type error in >=")
    | "<=" -> (match v1, v2 with
               | VInt a,    VInt b    -> VBool (a <= b)
               | VString a, VString b -> VBool (a <= b)
               | _ -> failwith "type error in <=")
    | _ -> failwith ("unknown operator: " ^ op)
  in
  (result, env2)

(* Evaluates a shell command. Each argument expression is converted to a string
   first. cd and exit are built-ins that run in the shell process itself;
   everything else is executed via fork + execvp (see foo.ml : exec_command). *)
and eval_cmd args env =
  let arg_to_str a = value_to_string (fst (eval a env)) in
  let strs = map arg_to_str args in
  match strs with
  | [] -> failwith "empty command"

  (* cd must be a built-in: Unix.chdir in a child process only changes that
     child's directory, not the shell's own working directory. *)
  | "cd" :: rest ->
      let dir = match rest with
        | []  -> (try Sys.getenv "HOME" with Not_found -> "/")
        | [d] -> d
        | _   -> failwith "cd: too many arguments"
      in
      (try Unix.chdir dir; (VBool true, env)
       with Unix.Unix_error (e, _, _) ->
         Printf.eprintf "cd: %s: %s\n%!" dir (Unix.error_message e);
         (VBool false, env))

  (* exit must be a built-in: it terminates the interpreter process itself. *)
  | "exit" :: rest ->
      let code = match rest with
        | []  -> 0
        | [n] -> (try int_of_string n with _ -> 0)
        | _   -> 0
      in
      exit code

  (* External command: create a new child process via fork.
     The child replaces its image with the command (execvp).
     The first element of argv must be the command name itself. *)
  | cmd :: rest ->
      (match Unix.fork () with
       | 0 ->
           (* child: replace this process image with the command to run. *)
           (try Unix.execvp cmd (to_array (cmd :: rest))
            with Unix.Unix_error (e, _, _) ->
              Printf.eprintf "%s: %s\n%!" cmd (Unix.error_message e);
              exit 127)
       | child_pid ->
           (* parent : wait explicitly for this specific child to finish.
              WUNTRACED also catches stopped processes (Ctrl+Z). *)
           (match Unix.waitpid [Unix.WUNTRACED] child_pid with
            | (_, Unix.WEXITED 0) ->
                (VBool true, env)
            | (_, Unix.WEXITED _) ->
                (* Non-zero exit is normal shell "false" (e.g. test returning 1). *)
                (VBool false, env)
            | (dead_pid, Unix.WSIGNALED signal) ->
                Printf.eprintf "process %d interrupted by signal %d\n%!" dead_pid signal;
                (VBool false, env)
            | (aslept_pid, Unix.WSTOPPED signal) ->
                Printf.eprintf "process %d stopped by signal %d\n%!" aslept_pid signal;
                (VBool false, env)))

(* Implements e1 | e2 using a Unix pipe (see foo.ml : pipe_commands).
   A child process evaluates e1 with its stdout wired to the write end.
   The parent evaluates e2 with its stdin wired to the read end.
   stdin is saved and restored so the REPL keeps reading from the keyboard. *)
and eval_pipe e1 e2 env =
  let (fd_in, fd_out) = Unix.pipe () in
  let saved_stdin = Unix.dup Unix.stdin in
  match Unix.fork () with
  | 0 ->
      (* left side: redirect stdout to the write end of the pipe, then evaluate e1. 
      The read end is unused here and must be closed so the parent's read does not block forever. *)
      Unix.dup2 fd_out Unix.stdout;
      Unix.close fd_out;
      Unix.close fd_in;
      Unix.close saved_stdin;
      ignore (eval e1 env);
      exit 0
  | left_pid ->
      (* right side: connect the read end of the pipe to stdin, then evaluate e2 which will read what the child wrote. *)
      Unix.dup2 fd_in Unix.stdin;
      Unix.close fd_out;
      Unix.close fd_in;
      let result = eval e2 env in
      ignore (Unix.waitpid [Unix.WUNTRACED] left_pid);
      Unix.dup2 saved_stdin Unix.stdin;
      Unix.close saved_stdin;
      result
