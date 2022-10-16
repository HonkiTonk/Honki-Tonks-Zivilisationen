
pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with WichtigesRecordKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with GrafikDatentypen;

with SchreibeStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartenfelderBewertenLogik;
with LadezeitenLogik;
with NachGrafiktask;

package body RasseEntfernenLogik is

   procedure RasseEntfernen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         SpielVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert) := WichtigesRecordKonstanten.LeerDiplomatie;
         SpielVariablen.Diplomatie (DiplomatieSchleifenwert, RasseExtern) := WichtigesRecordKonstanten.LeerDiplomatie;
         
      end loop DiplomatieSchleife;
      
      if
        RasseExtern = NachGrafiktask.AktuelleRasse
      then
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         
      else
         null;
      end if;
      
      SpielVariablen.CursorImSpiel (RasseExtern) := WichtigesRecordKonstanten.LeerCursor;
      SpielVariablen.Wichtiges (RasseExtern) := WichtigesRecordKonstanten.LeerWichtigesZeug;
      
      SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.Leer_Spieler_Enum;
      SpielVariablen.Rassenbelegung (RasseExtern).Besiegt := True;
      
   end RasseEntfernen;
   
   
   
   procedure RasseExistenzPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      RasseEntfernen (RasseExtern => RasseExtern);
      
   end RasseExistenzPrüfen;
   
   
   
   procedure RasseAufKISetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.KI_Spieler_Enum;
      LadezeitenLogik.SpielweltNullsetzen;
      KartenfelderBewertenLogik.KartenfelderBewerten (RasseExtern => RasseExtern);
      
   end RasseAufKISetzen;

end RasseEntfernenLogik;
