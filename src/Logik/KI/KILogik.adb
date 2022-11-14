with EinheitenKonstanten;
with KartenverbesserungDatentypen;
with LadezeitenDatentypen;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

with LadezeitenLogik;

with KIStadtLogik;
with KIForschungLogik;
with KIDiplomatieLogik;
with KIEinheitLogik;

package body KILogik is

   procedure KI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschungLogik.Forschung (RasseExtern => RasseExtern);
      KIDiplomatieLogik.Diplomatie (RasseExtern => RasseExtern);
            
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Einheitenzeitwert := (SpielVariablen.Grenzen (RasseExtern).Einheitengrenze + (100 - 1)) / 100;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KIEinheitLogik.Einheit (EinheitRasseNummerExtern => (RasseExtern, EinheitenSchleifenwert));
         end case;
            
         case
           EinheitenSchleifenwert mod Einheitenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
               
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Einheiten_Enum);
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      Städtezeitwert := StadtDatentypen.MaximaleStädte ((Positive (SpielVariablen.Grenzen (RasseExtern).Städtegrenze) + (100 - 1)) / 100);
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
            
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               KIStadtLogik.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
            
         case
           StadtSchleifenwert mod Städtezeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittKISchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      LadezeitenLogik.FortschrittKIMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Berechne_Städte_Enum);
      
   end StädteDurchgehen;

end KILogik;
