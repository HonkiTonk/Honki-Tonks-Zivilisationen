with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenErkundenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   UmgebungPrüfen : KartenDatentypen.KartenfeldNatural;
   BereitsGeprüft : KartenDatentypen.KartenfeldNatural;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Zufallsmultiplikator : KartenRecords.AchsenKartenfeldRecord;
   
   
   
   function ZielSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KartenreichweiteExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KIEinheitFestlegenErkundenLogik;
