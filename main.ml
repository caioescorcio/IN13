(* exercices.ml *)

(* identity *)
let id = fun x -> x ;;

(* vowel counter *)
let rec cpt_voy str = 
    let rec foo_voy i str n = 
        if i < String.length str then 
            match str.[i] with
            |'a'|'A'|'e'|'E'|'i'|'I'|'o'|'O'|'u'|'U'|'y'|'Y' -> 
                foo_voy (i+1) str n+1 
            | _ -> foo_voy (i+1) str n  (*in other cases we use _*)
        else n

        in foo_voy 0 str 0;;    (*first use*)

(* interval calculator *)
let somme_inter (a, b : float*float) (c, d : float*float) = (*pair declaration, _tuple_*)
    (a *. c , b *. d);; (* *. for the floating operation *)

(* aplication of a function squared = fof(x)*)
let puiss_2 f x = f (f x);;

let rec base8 (x:int) =
    let rec foo_convert x buff =
        if x / 8 <= 0 then
            string_of_int x ^ buff (* ^ for ensembling 2 strings *)
        else
            foo_convert (x / 8) (string_of_int (x mod 8) ^ buff)
    in foo_convert x "";;

(* define type feu that can be one of 3 options, they are in caps because they are not variables but arbitrary attributes*)
type feu = Rouge | Orange | Vert;;

let nom_feu (f: feu) : string =
    match f with
    | Rouge -> "rouge"
    | Orange -> "orange"
    | Vert -> "vert"


(* recursive tree: alpha = feuille or noeud. Each noeud has 2 other feuilles *)
type 'a arbre =     (* 'a = tree of anything *)
    | Feuille of 'a
    | Noeud of 'a arbre * 'a arbre

let rec prof_max (a : 'a arbre) : int =
    match a with
    | Feuille _ -> 1  (* if a = feuille +1 of deepness. Feuille _ indicates that we wont use its value*)
    | Noeud (g, d) -> 1 + max (prof_max g) (prof_max d)   (* else calculate the max deepness of the other noeuds *)

let rec dernier = function  (* recursive function*)
    | [] -> raise (Failure "trop courte")   (* if empty list : raise exception *)
    | [x] -> x  (* if last element, return the element*)
    | _ :: q -> dernier q   (* if followed by another element, return the function applied to it*)
        (* list a :: b => next list element is b *)
;;


let rec avant_dernier = function 
    | [] -> raise (Failure "trop courte")
    | [x; y] -> x   (* it verifies the tuple [x; y] before the recursive step *)
    | _ :: q -> avant_dernier q

let rec nieme l n = 
    if n < 0 then raise (Failure "n inferieur à zero")
    else
        match l with
        | [] -> raise (Failure "trop courte")
        | x :: _ when n = 0 -> x    (* the 'when' is used as an 'if' to verify the condition for n *)
        | _ :: q -> nieme q (n - 1)
        (* at the end of the list, it looks like a :: [] (for a = last element followed by an empty list) thats the reason because the extract x :: _ works *)
    ;;

let rec nieme_bis l n = 
    if n < 0 then None
    else
        match l with
        | [] -> None
        | x :: _ when n = 0 -> Some x (* Option type = None or Some x, so it is required to use it as Some*)
        | _ :: q -> nieme_bis q (n - 1)
    ;;

let rec copie = function
    | [] -> []  (* end condition = empty list *)
    | x :: q -> x :: copie q    (* if the element is followed by another, it returns the element followed by the rest of the list copied*)
;;

let rec reverse = function
    | [] -> []
    | x :: y -> reverse y @ [x] (* [a]@[b] = concatenation operator*)
;;

let rec sans_repetitions = function
    | [] -> []
    | [x] -> [x]
    | x1 :: (x2 :: y as tail)-> if x1 = x2 then sans_repetitions tail (* it is necessary to place the rest of the list - as in x1 :: x2 :: x3 like x1 :: (x2::x3) otherwise the code thinks it is a triplet*)
                        (* we can also use (EXPRESSION as NAME) not to repeat its terms*)
                                else x1 :: sans_repetitions tail    (* we return the list followed by its version without repetition*)

let trie_selon_la_longueur (l : 'a list list) : 'a list list =  (* l = list of lists so 'a list list |||| and its return value 'a list list*)
    List.sort (fun a b -> compare (List.length a) (List.length b)) l (* sort list by the following method: List.sort (COMPARISON FUNCTION) List *)
;;

(* receive a function and a list of arguments and returns a list of the function applied to each other list member *)
let rec appl_1_sur_2 f = function
    | [] -> []
    | [x] -> [f x]           (* only one element left -> apply f *)
    | x :: _ :: q -> f x :: appl_1_sur_2 f q  (* ignores the following element*)
    ;;

let rec tableau_de_liste (a : 'a array) : 'a list = 
    let rec foo_tab_list n =    (* auxiliar function to count the elements*)
        if n = Array.length a then
            []
        else
           a.(n) :: foo_tab_list (n+1)  (* return the members of the array to the list*)
    in foo_tab_list 0;;


let rec separe l : (int list * int list) =
    match l with
    | [] -> ([], [])    
    | x :: r -> (* if there are a next element before a list*)
        let evens, odds = separe r in (* gets the 2 lists on the result of the given separe*)
            (* separation between evens and odds as the return value*)
            if x mod 2 = 0 then (x :: evens, odds)  (* checks if the current value is pair and applies the function on it in the 2 sides*)
            else (evens, x :: odds)
    ;;


(* the ensemble can the both of the following types *)
type ensemble =
    | Interval of int * int
    | List of int list
;;


let intersec e1 e2 =
    match e1, e2 with
        | Interval (a1, b1), Interval(a2, b2) -> max a1 a2 <= min b1 b2
        | Interval (a,b), List l | List l, Interval (a,b) -> List.exists (fun x -> x >= a && x <= b) l
        | List l1, List l2 -> List.exists (fun x -> List.mem x l2) l1
    ;;
