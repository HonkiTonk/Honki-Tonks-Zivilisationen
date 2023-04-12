with KartenverbesserungDatentypen;
with EinheitenKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;

package body KIStadtLaufendeBauprojekteLogik is

   function StadtLaufendeBauprojekte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      GleichesGebäudeBauprojekt := StadtKonstanten.LeerNummer;
     
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
            
         if
           StadtNummerSchleifenwert = StadtSpeziesNummerExtern.Nummer
           or
             LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Gebäude = BauprojektExtern.Gebäude
           or
             LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit = BauprojektExtern.Einheit
         then
            GleichesGebäudeBauprojekt := GleichesGebäudeBauprojekt + 1;
               
         else
            null;
         end if;
            
      end loop StadtSchleife;
      
      return GleichesGebäudeBauprojekt;
      
   end StadtLaufendeBauprojekte;
   
   
   
   function GleicheEinheitArtBauprojekte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is
      use type EinheitenDatentypen.Einheitart_Enum;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      GleichesEinheitenBauprojekt := EinheitenKonstanten.LeerNummer;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
            
         if
           StadtNummerSchleifenwert = StadtSpeziesNummerExtern.Nummer
           or
             LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         elsif
           LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit /= 0
         then
            if
              EinheitArtExtern = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                      IDExtern      => LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Einheit)
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      EinheitenImBau := EinheitenKonstanten.LeerNummer;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtDatentypen.MaximaleStädte'First .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)).Einheit = StadtKonstanten.LeerBauprojekt.Einheit
         then
            null;
            
         else
            EinheitenImBau := EinheitenImBau + 1;
         end if;
         
      end loop StadtSchleife;
      
      return EinheitenImBau;
      
   end EinheitenInProduktion;

end KIStadtLaufendeBauprojekteLogik;
