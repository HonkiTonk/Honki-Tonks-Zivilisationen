with EinheitenRecords;
with StadtRecords;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;
with EinheitenGrafikRecords;
with StadtDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package UebergabeRecordErmittelnGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.Einheitenbereich;
   use type StadtDatentypen.Städtebereich;

   function Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenGrafikRecords.EinheitGrafikRecord;
   --  with
   --    Pre => (
   --              EinheitSpeziesNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
   --            and
   --              LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
    --          );
   
   function Stadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtGrafikRecords.StadtGrafikRecord;
    -- with
    --   Pre => (
    --            StadtSpeziesNummerExtern.Nummer <= LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              -- and
              --   LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
    --          );
   
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
