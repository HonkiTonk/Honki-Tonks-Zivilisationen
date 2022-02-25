pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenVerbesserungKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;

package body KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BauprojektExtern : in EinheitStadtRecords.BauprojektRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesBauprojekt := 0;
     
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Platznummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = KartenVerbesserungKonstanten.LeerVerbesserung
         then
            null;
            
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = BauprojektExtern.GebäudeEinheit
           and
             LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = BauprojektExtern.Nummer
         then
            GleichesBauprojekt := GleichesBauprojekt + 1;
               
         else
            null;
         end if;
            
      end loop StadtSchleife;
      
      return GleichesBauprojekt;
      
   end StadtLaufendeBauprojekte;
   
   
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitArtExtern : in EinheitStadtDatentypen.Einheit_Art_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesBauprojekt := 0;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Platznummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = KartenVerbesserungKonstanten.LeerVerbesserung
         then
            null;
               
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = False
         then
            if
              LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer))
              = EinheitArtExtern
            then
               GleichesBauprojekt := GleichesBauprojekt + 1;
                     
            else
               null;
            end if;
         end if;
         
      end loop StadtSchleife;
      
      return GleichesBauprojekt;
      
   end GleicheEinheitArtBauprojekte;

end KIStadtLaufendeBauprojekte;
