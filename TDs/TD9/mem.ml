(* La m�moire globale. Initialement de taille 256, au hasard, remplie avec la
   valeur 0. S'il n'y a vraiment plus de place, on devrait r�allouer de la
   m�moire. Pour simplifier, ici, on �chouera simplement. *)
let mem = {
  VmBytecode.size = 256 ;   (* Chaque tas fait initialement 256. *)
  VmBytecode.next_free = 0 ;
  VmBytecode.heap_base = 0 ; (* Sera 0 ou size pour dire dans quel tas on
                                alloue. *)
  (* Comme on a 2 tas, on alloue le tableau de 2 fois la taille. *)
  VmBytecode.data = Array.make (2 * 256) (VmBytecode.VMV_int 0)
} ;;


(* Compteur global permettant, lors de la phase de copie, de savoir o� l'on
   doit copier dans le tas destination. C'est plus simple de l'avoir en
   global plut�t que de devoir se trimbaler cet index partout.
   ATTENTION: doit �tre r�initialis� en d�but de GC, � la valeur de base
   du tas destination de la copie. *)
let next_free_in_to = ref 0 ;;


(* from_addr = addresse de bloc. On r�cup�re la taille dans la case
   pr�c�dente. *)
let rec copy_block from_addr block_size =
   let nf = ref mem.next_free in (*mutable variable*)
   mem.data.(!nf) <- VmBytecode.VMV_int block_size ;
   nf := mem.next_free + 1;
   let rec copy_block_addr i size =
      if i != size+1 then
         (
         mem.data.(!nf + i) <- mem.data.(!from_addr + i);
         copy_block_addr (i+1) size
         )
      in copy_block_addr 0 block_size;
   mem.next_free <- !nf + block_size;
   mem.next_free - block_size;
  
;;


(* Transf�re la m�moire se trouvant � [addr] dans le tas TO si �a n'a pas
   d�j� �t� fait et met un pointeur distant dans le bloc dans le tas FROM.
   Pour savoir si le bloc se trouvant � [addr] a d�j� �t� transf�r�, il
   suffit de regarder s'il contient une adresse distante, donc si dans
   mem[addr] on trouve une VMV_addr d�signant une adresse dans le bloc TO. *)
let rec transfer_pointer addr =
  raise (Failure "� compl�ter : transfer_pointer")
;;


(* Copie des racines. Retourne la valeur de la nouvelle racine et d�clenche
   Si n�cessaire la copie et le relogement de pointeur si la racine en est
   un. *)
let copy_root v =
  raise (Failure "� compl�ter : copy_root")
;;


(* D�clenchement du GC. *)
let gc vm_state =
  raise (Failure "� compl�ter : gc")
;;


(* Allocation d'un bloc m�moire de taille donn�e. S'il n'y a plus assez de
   m�moire dans le tas, d�clenche un GC. *)
let new_block vm_state alloc_size =
  (* L'allocation effective sera de 1 de plus pour pouvoir m�moriser
     la taille du bloc. *)
  let vm_state' =
    if (mem.next_free - mem.heap_base) + alloc_size + 1 >= mem.size then (
      (* Besoin de d�clencher un GC car plus assez de m�moire. *)
      let state = gc vm_state in
      (* On v�rifie s'il reste bien de la m�moire apr�s le GC, sinon on
         �choue. On fait une version simplifi�e qui ne r�alloue pas de tas. *)
      if (mem.next_free - mem.heap_base) + alloc_size + 1 >= mem.size then
        raise (Failure "Really no more memory") ;
      state
     )
    else vm_state in
  (* L'adresse du bloc est celle juste apr�s son champ de taille. C'est cette
     adresse que l'on retourne � "l'utilisateur". *)
  let tmp = mem.next_free + 1 in
  (* On m�morise la taille du bloc. *)
  mem.data.(mem.next_free) <- VmBytecode.VMV_int alloc_size ;
  (* On fait progresser l'indice de prochain bloc libre. Comme on a pris une
     case pour mettre la taille du bloc, il ne faut pas oublier le + 1. *)
  mem.next_free <- mem.next_free + alloc_size + 1 ;
  (* On retourne l'adresse du bloc allou�. *)
  (tmp, vm_state')
;;
