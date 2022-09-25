pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;

package body KIStadtLaufendeBauprojekteLogik is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesGebäudeBauprojekt := 0;
     
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Nummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Gebäude = BauprojektExtern.Gebäude
           or
             LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Einheit = BauprojektExtern.Einheit
         then
            GleichesGebäudeBauprojekt := GleichesGebäudeBauprojekt + 1;
               
         else
            null;
         end if;
            
      end loop StadtSchleife;
      
      return GleichesGebäudeBauprojekt;
      
   end StadtLaufendeBauprojekte;
   
   
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      GleichesEinheitenBauprojekt := 0;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Nummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Einheit /= 0
         then
            if
              EinheitArtExtern = LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                    IDExtern    => EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Einheit))
            then
               GleichesEinheitenBauprojekt := GleichesEinheitenBauprojekt + 1;
                     
            else
               null;
            end if;
         end if;
         
      end loop StadtSchleife;
      
      return GleichesEinheitenBauprojekt;
      
   end GleicheEinheitArtBauprojekte;

end KIStadtLaufendeBauprojekteLogik;
