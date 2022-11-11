with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;

package body KIStadtLaufendeBauprojekteLogik is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesGebäudeBauprojekt := StadtKonstanten.LeerNummer;
     
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
      
      GleichesEinheitenBauprojekt := EinheitenKonstanten.LeerNummer;
      
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
              EinheitArtExtern = LeseEinheitenDatenbank.Einheitenart (RasseExtern => StadtRasseNummerExtern.Rasse,
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
   
   
   
   function EinheitenInProduktion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitenImBau := EinheitenKonstanten.LeerNummer;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtDatentypen.MaximaleStädte'First .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)).Einheit = StadtKonstanten.LeerBauprojekt.Einheit
         then
            null;
            
         else
            EinheitenImBau := EinheitenImBau + 1;
         end if;
         
      end loop StadtSchleife;
      
      return EinheitenImBau;
      
   end EinheitenInProduktion;

end KIStadtLaufendeBauprojekteLogik;
