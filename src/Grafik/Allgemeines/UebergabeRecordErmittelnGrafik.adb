with EinheitenKonstanten;
with KartenRecordKonstanten;
with TextKonstanten;

with LeseEinheitenGebaut;
with LeseStadtGebaut;

package body UebergabeRecordErmittelnGrafik is

   function Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenGrafikRecords.EinheitGrafikRecord
   is begin
      
      ZwischenspeicherEinheit.SpeziesNummer := EinheitSpeziesNummerExtern;
      
      case
        EinheitSpeziesNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            ZwischenspeicherEinheit.ID := EinheitenKonstanten.LeerID;
            ZwischenspeicherEinheit.Koordinaten := KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            ZwischenspeicherEinheit.ID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            ZwischenspeicherEinheit.Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      return ZwischenspeicherEinheit;
      
   end Einheit;
   
   
   
   -- Hier noch weitere Prüfungen einbauen, für den Fall das beim Lesen der Stadt die Stadt entfernt wird? äöü
   -- Eventuell dann einen leeren Wert zurückgeben, bei Grafik prüfen und gegebenenfalls gar nicht erst die Stadt anzeigen? äöü
   function Stadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtGrafikRecords.StadtGrafikRecord
   is begin
      
      ZwischenspeicherStadt.SpeziesNummer := StadtSpeziesNummerExtern;
      
      case
        StadtSpeziesNummerExtern.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            ZwischenspeicherStadt.ID := StadtKonstanten.LeerID;
            ZwischenspeicherStadt.Koordinaten := KartenRecordKonstanten.LeerKoordinate;
            ZwischenspeicherStadt.EinwohnerArbeiter := (others => StadtKonstanten.LeerEinwohner);
            ZwischenspeicherStadt.Nahrungsmittel := StadtKonstanten.LeerNahrungsmittel;
            ZwischenspeicherStadt.Nahrungsproduktion := StadtKonstanten.LeerNahrungsproduktion;
            ZwischenspeicherStadt.Produktionrate := StadtKonstanten.LeerProduktionrate;
            ZwischenspeicherStadt.Geldgewinnung := StadtKonstanten.LeerGeldgewinnung;
            ZwischenspeicherStadt.Forschungsrate := StadtKonstanten.LeerForschungsrate;
            ZwischenspeicherStadt.Bauprojekt := StadtKonstanten.LeerBauprojekt;
            ZwischenspeicherStadt.Bauzeit := StadtKonstanten.LeerBauzeit;
            ZwischenspeicherStadt.Korruption := StadtKonstanten.LeerKorruption;
            ZwischenspeicherStadt.GebäudeVorhanden := (others => StadtKonstanten.LeerGebäude);
            ZwischenspeicherStadt.UmgebungBewirtschaftung := (others => (others => StadtKonstanten.LeerUmgebungBewirtschaftet));
            
         when others =>
            ZwischenspeicherStadt.ID := LeseStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Koordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.EinwohnerArbeiter := (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                           EinwohnerArbeiterExtern  => True),
                                                        LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                           EinwohnerArbeiterExtern  => False));
            ZwischenspeicherStadt.Nahrungsmittel := LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Nahrungsproduktion := LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Produktionrate := LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Geldgewinnung := LeseStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Forschungsrate := LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Bauzeit := LeseStadtGebaut.Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.Korruption := LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.GebäudeVorhanden := LeseStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherStadt.UmgebungBewirtschaftung := LeseStadtGebaut.GesamteBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      return ZwischenspeicherStadt;
      
   end Stadt;
   
   
   
   function Bauauswahl
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtGrafikRecords.BaumenüGrafikRecord
   is begin
      
      ZwischenspeicherBauauswahl.Spezies := StadtSpeziesNummerExtern.Spezies;
      
      case
        StadtSpeziesNummerExtern.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            ZwischenspeicherBauauswahl.Bauprojekt := StadtKonstanten.LeerBauprojekt;
            ZwischenspeicherBauauswahl.Bauzeit := StadtKonstanten.LeerBauzeit;
                        
         when others =>
            ZwischenspeicherBauauswahl.Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            ZwischenspeicherBauauswahl.Bauzeit := LeseStadtGebaut.Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;

      return ZwischenspeicherBauauswahl;
      
   end Bauauswahl;
   
   
   
   function SpeziesStadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return EinheitenGrafikRecords.SpeziesStadtnameGrafikRecord
   is begin
      
      ZwischenspeicherSpeziesStadtname.Spezies := StadtSpeziesNummerExtern.Spezies;
      
      case
        StadtSpeziesNummerExtern.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            ZwischenspeicherSpeziesStadtname.Stadtname := TextKonstanten.LeerUnboundedString;
                        
         when others =>
            ZwischenspeicherSpeziesStadtname.Stadtname := LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      return ZwischenspeicherSpeziesStadtname;
      
   end SpeziesStadtname;
     
end UebergabeRecordErmittelnGrafik;
