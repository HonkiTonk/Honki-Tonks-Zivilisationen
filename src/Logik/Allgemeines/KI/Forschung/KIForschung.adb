pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with LadezeitenDatentypen;

with LeseForschungenDatenbank;
with SchreibeWichtiges;
with LeseWichtiges;

with KIDatentypen; use KIDatentypen;

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
      
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
         
         case
           ForschungAllgemein.ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                            ForschungIDExtern => ForschungSchleifenwert)
         is
            when True =>
               MöglicheForschungen (ForschungSchleifenwert) := 1;
                     
            when False =>
               MöglicheForschungen (ForschungSchleifenwert) := 0;
         end case;
         
         if
           ZahlenDatentypen.EigenesPositive (ForschungSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (ForschungenDatenbank.ForschungslisteArray'Last (2)) / 1
         then
            ------------------------------- Bringt noch Warnmeldungen bei Forschung, warum auch immer.
            Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
            Multiplikator := Multiplikator + 1;
            delay 0.01;
               
         else
            null;
         end if;
               
      end loop ForschungenSchleife;
      
      WelchesProjekt := ForschungenDatentypen.ForschungIDMitNullWert'First;
      Multiplikator := 1;
      
      BewertungSchleife:
      for BewertungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
            
         if
           MöglicheForschungen (BewertungSchleifenwert) <= 0
         then
            null;
               
         elsif
           WelchesProjekt = ForschungenDatentypen.ForschungIDMitNullWert'First
         then
            WelchesProjekt := BewertungSchleifenwert;
               
         elsif
           LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                    IDExtern    => WelchesProjekt)
           > LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                      IDExtern    => BewertungSchleifenwert)
         then
            WelchesProjekt := BewertungSchleifenwert;

         else
            null;
         end if;
         
         if
           ZahlenDatentypen.EigenesPositive (BewertungSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (ForschungenDatenbank.ForschungslisteArray'Last (2)) / 1
         then
            ------------------------------- Bringt noch Warnmeldungen bei Forschung, warum auch immer.
            Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Forschung_Enum);
            Multiplikator := Multiplikator + 1;
            delay 0.01;
               
         else
            null;
         end if;
                 
      end loop BewertungSchleife;
      
      ---------------------- Solche Prüfungen alle mal nach Lese/Schreibe verschieben? Dann müsste ich die auch nicht immer wieder lokal Wiederholen. Dafür halt mehr Aufrufe, sollte aber ignorierbar sein.
      case
        WelchesProjekt
      is
         when ForschungenDatentypen.ForschungIDMitNullWert'First =>
            null;
            
         when others =>
            SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                                 ForschungIDExtern => WelchesProjekt);
      end case;
      
   end NeuesForschungsprojekt;

end KIForschung;
