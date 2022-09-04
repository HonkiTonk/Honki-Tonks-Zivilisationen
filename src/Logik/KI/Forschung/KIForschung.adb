pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with LadezeitenDatentypen;
with ForschungKonstanten;

with LeseForschungenDatenbank;
with SchreibeWichtiges;
with LeseWichtiges;

with ForschungAllgemein;
with LadezeitenLogik;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when ForschungKonstanten.LeerForschung =>
            NeuesForschungsprojekt (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
      
   end Forschung;
   
   
   
   -- Das muss durch eine bessere Berechnung ersetzt werden. äöü
   -- Bei Erweiterung der Forschungsliste muss die Ladezeitberechnung angepasst werden. äöü
   procedure NeuesForschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WelchesProjekt := ForschungKonstanten.LeerForschung;
      
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
         
         case
           ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                            ForschungIDExtern => ForschungSchleifenwert)
         is
            when True =>
               if
                 WelchesProjekt = ForschungKonstanten.LeerForschung
               then
                  WelchesProjekt := ForschungSchleifenwert;
                  
               elsif
                 LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                          IDExtern    => WelchesProjekt)
                 > LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                            IDExtern    => ForschungSchleifenwert)
               then
                  WelchesProjekt := ForschungSchleifenwert;
                  
               else
                  null;
               end if;
                     
            when False =>
               null;
         end case;
         
         LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
               
      end loop ForschungenSchleife;
      
      -- Solche Prüfungen alle mal nach Lese/Schreibe verschieben? Dann müsste ich die auch nicht immer wieder lokal Wiederholen. Dafür halt mehr Aufrufe, sollte aber ignorierbar sein. äöü
      case
        WelchesProjekt
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                 ForschungIDExtern => WelchesProjekt);
      end case;
      
   end NeuesForschungsprojekt;

end KIForschung;
