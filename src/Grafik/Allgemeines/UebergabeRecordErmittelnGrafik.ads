with EinheitenRecords;
with StadtRecords;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package UebergabeRecordErmittelnGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitGrafikRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   -- Die Contracts hier und bei der Bauauswahl auf <= anstellte von in ändern. äöü
   function Stadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.StadtGrafikRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function Bauauswahl
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BaumenüGrafikRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   ZwischenspeicherEinheit : EinheitenRecords.EinheitGrafikRecord;
   
   ZwischenspeicherStadt : StadtRecords.StadtGrafikRecord;
   
   ZwischenspeicherBauauswahl : StadtRecords.BaumenüGrafikRecord;

end UebergabeRecordErmittelnGrafik;
