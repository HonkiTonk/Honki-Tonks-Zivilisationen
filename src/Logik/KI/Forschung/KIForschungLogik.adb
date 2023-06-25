with ProduktionDatentypen;
with LadezeitenDatentypen;
with ForschungKonstanten;

with LeseForschungenDatenbank;
with SchreibeWichtiges;
with LeseWichtiges;

with ForschungstestsLogik;
with LadezeitenLogik;

package body KIForschungLogik is

   procedure Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern)
      is
         when ForschungKonstanten.LeerForschung =>
            NeuesForschungsprojekt (SpeziesExtern => SpeziesExtern);
            
         when others =>
            null;
      end case;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
      
   end Forschung;
   
   
   
   -- Das muss durch eine bessere Berechnung ersetzt werden. äöü
   -- Bei Erweiterung der Forschungsliste muss die Ladezeitberechnung angepasst werden. äöü
   procedure NeuesForschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
      use type ProduktionDatentypen.Produktion;
   begin
      
      Ladezeit := ForschungenDatentypen.ForschungID (Basiszeitwert (ZusatzwertExtern => Positive (ForschungenDatenbank.ForschungslisteArray'Last (2)),
                                                                    TeilerExtern     => 100));
      WelchesProjekt := ForschungKonstanten.LeerForschung;
      
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
         
         case
           ForschungstestsLogik.ForschungAnforderungErfüllt (SpeziesExtern     => SpeziesExtern,
                                                              ForschungIDExtern => ForschungSchleifenwert)
         is
            when True =>
               if
                 WelchesProjekt = ForschungKonstanten.LeerForschung
               then
                  WelchesProjekt := ForschungSchleifenwert;
                  
               elsif
                 LeseForschungenDatenbank.Kosten (SpeziesExtern => SpeziesExtern,
                                                  IDExtern      => WelchesProjekt)
                 > LeseForschungenDatenbank.Kosten (SpeziesExtern => SpeziesExtern,
                                                    IDExtern      => ForschungSchleifenwert)
               then
                  WelchesProjekt := ForschungSchleifenwert;
                  
               else
                  null;
               end if;
                     
            when False =>
               null;
         end case;
         
         case
           ForschungSchleifenwert mod Ladezeit
         is
            when 0 =>
               LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
               
            when others =>
               null;
         end case;
               
      end loop ForschungenSchleife;
      
      SchreibeWichtiges.Forschungsprojekt (SpeziesExtern     => SpeziesExtern,
                                           ForschungIDExtern => WelchesProjekt);
      
   end NeuesForschungsprojekt;

end KIForschungLogik;
