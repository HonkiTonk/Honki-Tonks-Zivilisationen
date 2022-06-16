pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with KartenVerbesserungDatentypen;
with SpielVariablen;

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
      Ladezeiten.FortschrittKISchreiben (RasseExtern => RasseExtern);
      
      StädteDurchgehen (RasseExtern => RasseExtern);
      Ladezeiten.FortschrittKISchreiben (RasseExtern => RasseExtern);
      
      KIForschung.Forschung (RasseExtern => RasseExtern);
      Ladezeiten.FortschrittKISchreiben (RasseExtern => RasseExtern);
      
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      Ladezeiten.FortschrittKISchreiben (RasseExtern => RasseExtern);
                  
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerEinsSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KIEinheitHandlungen.EinheitHandlungen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
         end case;
            
      end loop EinheitenSchleife;
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtNummerEinsSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
            
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KIStadt.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));
         end case;

      end loop StadtSchleife;
      
   end StädteDurchgehen;

end KI;
