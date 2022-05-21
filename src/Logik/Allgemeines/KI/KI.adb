pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitenKonstanten;
with KartenVerbesserungDatentypen;
with SpielVariablen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KIStadt;
with KIForschung;
with KIDiplomatie;
with KIEinheitHandlungen;

package body KI is

   procedure KI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      ---------------------- Mehr NotAus in die Loops der KI einbauen, sonst frisst die sich beispielsweise bei der Suche nach einem geeigneten Platz.
      ---------------------- Zusätzlich mal was einbauen dass die Anforderungen schrittweise reduziert.
      -- Das hier mal so lassen, für weitere Tests sicherlich nützlich.
      Put_Line ("EinheitenDurchgehen");
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      Put_Line ("StädteDurchgehen");
      StädteDurchgehen (RasseExtern => RasseExtern);
      Put_Line ("Forschung");
      KIForschung.Forschung (RasseExtern => RasseExtern);
      Put_Line ("Diplomatie");
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      Put_Line ("Fertig");
            
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
