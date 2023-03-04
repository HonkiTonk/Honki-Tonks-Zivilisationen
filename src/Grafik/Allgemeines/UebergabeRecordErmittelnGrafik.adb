with EinheitenKonstanten;

-- with LeseEinheitenGebaut;
with LeseStadtGebaut;

package body UebergabeRecordErmittelnGrafik is

   function Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitGrafikRecord
   is begin
      
      ZwischenspeicherEinheit.Spezies := EinheitSpeziesNummerExtern.Spezies;
      
      case
        EinheitSpeziesNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            null;
      end case;
      
      return ZwischenspeicherEinheit;
      
   end Einheit;
   
   
   
   function Stadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.StadtGrafikRecord
   is begin
      
      ZwischenspeicherStadt.Spezies := StadtSpeziesNummerExtern.Spezies;
      
      case
        StadtSpeziesNummerExtern.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
            
         when others =>
            null;
      end case;
      
      return ZwischenspeicherStadt;
      
   end Stadt;
   
   
   
   function Bauauswahl
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BaumenüGrafikRecord
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

end UebergabeRecordErmittelnGrafik;
