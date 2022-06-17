pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with KartenVerbesserungDatentypen;
with SpielVariablen;
with LadezeitenDatentypen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Ladezeiten;

with KIStadt;
with KIForschung;
with KIDiplomatie;
with KIEinheitHandlungen;

package body KI is

   procedure KI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschung.Forschung (RasseExtern => RasseExtern);
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Multiplikator := 1;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KIEinheitHandlungen.EinheitHandlungen (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert));
         end case;
            
         if
           ZahlenDatentypen.EigenesPositive (EinheitenSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (SpielVariablen.Grenzen (RasseExtern).Einheitengrenze) / 100
         then
            Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
            
      end loop EinheitenSchleife;
      
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Multiplikator := 1;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
            
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KIStadt.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
            
         if
           ZahlenDatentypen.EigenesPositive (StadtSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (SpielVariablen.Grenzen (RasseExtern).Städtegrenze) / 100
         then
            Ladezeiten.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;

      end loop StadtSchleife;
      
      Ladezeiten.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KI;
