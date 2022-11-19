with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;
private with KartenDatentypen;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenSiedelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private
   use type KartenDatentypen.Kartenfeld;

   FeldGutUndFrei : Boolean;

   UmgebungPrüfen : KartenDatentypen.KartenfeldNatural;
   BereitsGeprüft : KartenDatentypen.KartenfeldNatural;

   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;

   NeueStadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   MöglichesFeld : KartenRecords.AchsenKartenfeldNaturalRecord;
   MöglichesStadtfeld : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitenKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   Zufallsmultiplikator : KartenRecords.AchsenKartenfeldRecord;



   function StadtfeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  StadtfeldSuchen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  StadtfeldSuchen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  NeuesStadtfeld'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  NeuesStadtfeld'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenSiedelnLogik;
