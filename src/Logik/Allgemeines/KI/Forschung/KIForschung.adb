pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen;
with LadezeitenDatentypen;

with ForschungenDatenbank;

with SchreibeWichtiges;
with LeseWichtiges;

with ForschungAllgemein;
with Ladezeiten;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern)
      is
         when ForschungenDatentypen.ForschungIDMitNullWert'First =>
            NeuesForschungsprojekt (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;
      
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
      
   end Forschung;
   
   
   
   ------------------------------------- Das muss auch mal durch eine komplexere Berechnung ersetzt werden.
   procedure NeuesForschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Multiplikator := 1;
      
      ForschungSchleife:
      for TechnologieSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
               
         case
           ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                            ForschungIDExtern => TechnologieSchleifenwert)
         is
            when True =>
               SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                    ForschungIDExtern => TechnologieSchleifenwert);
               return;
                     
            when False =>
               null;
         end case;
         
         --------------------------------- Aufgrund der Größe der ForschungsID kommt es hier noch zu einer Warnung.
         if
           ZahlenDatentypen.EigenesPositive (TechnologieSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (ForschungenDatenbank.ForschungslisteArray'Last (2)) / 100
         then
            Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
               
      end loop ForschungSchleife;
      
   end NeuesForschungsprojekt;

end KIForschung;
