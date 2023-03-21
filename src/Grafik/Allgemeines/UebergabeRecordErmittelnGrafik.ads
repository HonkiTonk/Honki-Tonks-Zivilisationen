with EinheitenRecords;
with StadtRecords;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;
with EinheitenGrafikRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package UebergabeRecordErmittelnGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenGrafikRecords.EinheitGrafikRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   -- Die Contracts hier und bei der Bauauswahl auf <= anstellte von in ändern. äöü
   -- Wobei das ja nur aufgerufen werden sollte wenn da auch eine Stadt ist, oder? äöü
   -- Dann könnten die Contracts so bleiben, scheint bisher auch so zu funktionieren. äöü
   function Stadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtGrafikRecords.StadtGrafikRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Bauauswahl
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtGrafikRecords.BaumenüGrafikRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function SpeziesStadtname
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return EinheitenGrafikRecords.SpeziesStadtnameGrafikRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   ZwischenspeicherEinheit : EinheitenGrafikRecords.EinheitGrafikRecord;
   
   ZwischenspeicherStadt : StadtGrafikRecords.StadtGrafikRecord;
   
   ZwischenspeicherBauauswahl : StadtGrafikRecords.BaumenüGrafikRecord;
   
   ZwischenspeicherSpeziesStadtname : EinheitenGrafikRecords.SpeziesStadtnameGrafikRecord;

end UebergabeRecordErmittelnGrafik;
