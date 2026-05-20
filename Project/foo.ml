(* Doc de la lib Unix : https://v2.ocaml.org/api/Unix.html *)


(* Execute une commande et attend sa fin pour rendre la main. *)
let exec_command c_name args =
  match Unix.fork () with
  | 0 ->
      (* Fils, donc nouveau processus. Il doit remplacer son image par celle
         de la commande à exécuter. Le premier argument de argv[] est le nom
         de la commande elle-même. *)
      Unix.execvp c_name (Array.of_list (c_name :: args))
  | child_pid -> (
    (* Père, donc le processus original. Il doit attendre la fin de son
       fils. Ici, on attend explicitement la fin de CE fils. Si l'on voulait
       attendre la fin de n'importe quel fils (fork() multiples), on pourrait
       utiliser Unix. wait(). *)
      match Unix.waitpid [Unix.WUNTRACED] child_pid with
      | (dead_pid, Unix.WEXITED ret_code) ->
          Printf.printf "Process %d terminated normally with return code %d.\n"
            dead_pid ret_code
      | (dead_pid, Unix.WSIGNALED signal) ->
          Printf.printf "Process %d interrupted by signal %d.\n" dead_pid signal
      | (aslept_pid, Unix.WSTOPPED signal) ->
          (* A priori pas nécessaire si l'on retire le flag WUNTRACED de
             waidpid(). *)
          Printf.printf "Oops, process %d only aslept by signal %d.\n"
            aslept_pid signal
     )
;;


let pipe_commands c_name1 args1 c_name2 args2 =
  (* On crée un pipe et on récupère ses caneaux d'entrée et de sortie. *)
  let (fd_in, fd_out) = Unix.pipe () in
  (match Unix.fork () with
  | 0 ->
      (* Premier fils. Il va exécuter la première commande. *)
      Unix.dup2 fd_out Unix.stdout ; (* Envoie la sortie du tube sur stdout. *)
      Unix.close fd_out ;
      Unix.close fd_in ;
      Unix.execvp c_name1 (Array.of_list (c_name1 :: args1))
  | _ -> (
      (* Père. Il doit connecter l'entrée du tupe à stdin. *)
      Unix.dup2 fd_in Unix.stdin ;
      Unix.close fd_out ;
      Unix.close fd_in
     )) ;
  (* Toujours le père. Maintenant il faut faire un second fork() pour exécuter
     le seconde commande. *)
   (match Unix.fork () with
   | 0 ->
       (* Second fils. Il va exécuter le seconde commande. *)
       Unix.execvp c_name2 (Array.of_list (c_name2 :: args2))
   | _ ->
       (* Toujours le père. Il doit attendre la fin de ses 2 fils.
          [TODO] Un peu crado : on ne fait aucune vérification ici. *)
       ignore (Unix.wait ()) ;
       ignore (Unix.wait ())
   )
;;

(* Deux exemples de commandes. *)
exec_command "ls" ["-l"; "/usr"] ;;
exec_command "date" ["-j"] ;;

(* Un exemple de pipe : ls -l | wc -l. *)
pipe_commands "ls" ["-l"; "/usr"] "wc" ["-l"] ;;
