with ForschungKonstanten;

with LeseForschungenDatenbank;
with LeseWichtiges;

package body ForschungstestsLogik is

   function TechnologieVorhanden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDNichtMöglich)
      return Boolean
   is begin
      
      case
        TechnologieExtern
      is
         when ForschungKonstanten.ForschungUnmöglich =>
            return False;
            
         when ForschungKonstanten.LeerAnforderung =>
            return True;
            
         when others =>
            return LeseWichtiges.Erforscht (SpeziesExtern           => SpeziesExtern,
                                            WelcheTechnologieExtern => TechnologieExtern);
      end case;
            
   end TechnologieVorhanden;
   
   
   
   function ForschungAnforderungErfüllt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
   is begin
   
      case
        LeseWichtiges.Erforscht (SpeziesExtern           => SpeziesExtern,
                                 WelcheTechnologieExtern => ForschungIDExtern)
      is
         when True =>
            return False;
         
         when False =>
            null;
      end case;
      
      AnforderungSchleife:
      for AnforderungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
            
         Forschungsanforderungen := LeseForschungenDatenbank.AnforderungForschung (SpeziesExtern           => SpeziesExtern,
                                                                                   IDExtern                => ForschungIDExtern,
                                                                                   WelcheAnforderungExtern => AnforderungSchleifenwert);
         
         case
           TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                 TechnologieExtern => Forschungsanforderungen)
         is
            when True =>
               null;
               
            when False =>
               return False;
         end case;
               
      end loop AnforderungSchleife;
      
      return True;
      
   end ForschungAnforderungErfüllt;

end ForschungstestsLogik;
