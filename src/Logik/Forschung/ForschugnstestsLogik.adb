pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ForschungKonstanten;

with LeseForschungenDatenbank;
with LeseWichtiges;

package body ForschugnstestsLogik is

   function TechnologieVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDNichtMöglich)
      return Boolean
   is begin
      
      case
        TechnologieExtern
      is
         when ForschungKonstanten.ForschungUnmöglich =>
            return False;
            
         when ForschungKonstanten.LeerForschungAnforderung =>
            return True;
            
         when others =>
            return LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                            WelcheTechnologieExtern => TechnologieExtern);
      end case;
            
   end TechnologieVorhanden;
   
   
   
   function ForschungAnforderungErfüllt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
   is begin
   
      case
        LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                 WelcheTechnologieExtern => ForschungIDExtern)
      is
         when True =>
            return False;
         
         when False =>
            null;
      end case;
      
      AnforderungSchleife:
      for AnforderungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
            
         Forschungsanforderungen := LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                   IDExtern                => ForschungIDExtern,
                                                                                   WelcheAnforderungExtern => AnforderungSchleifenwert);
         
         case
           TechnologieVorhanden (RasseExtern       => RasseExtern,
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

end ForschugnstestsLogik;
