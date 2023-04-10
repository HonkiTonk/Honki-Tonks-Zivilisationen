with KartenDatentypen;
with SpeziesDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;
with LeseGrenzen;

with KIDatentypen;

package KIBewegungAllgemeinLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre => (
                 FeldKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 FeldKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function EinheitentauschMöglich
     (BlockierendeEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 BlockierendeEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => BlockierendeEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BlockierendeEinheitExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private

   BlockierendeStadt : SpeziesDatentypen.Spezies_Enum;
   
   BlockierendeEinheit : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   
   
   function FeldAngreifen
     (EigeneEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FeindlicheSpeziesEinheitExtern : in SpeziesDatentypen.Spezies_Enum;
      FeindlicheSpeziesStadtExtern : in SpeziesDatentypen.Spezies_Enum)
      return KIDatentypen.Bewegung_Enum
     with
       Pre => (
                 EigeneEinheitExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EigeneEinheitExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneEinheitExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIBewegungAllgemeinLogik;
