with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with StadtDatentypen;
private with SystemRecords;
private with StadtRecords;
private with AufgabenDatentypen;
private with KartenKonstanten;
private with KartenverbesserungDatentypen;

with LeseGrenzen;

private with LeseWeltkarteneinstellungen;

package StadtBauenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private
   use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;

   Stadtart : KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum;

   WelcherWeg : AufgabenDatentypen.Einheitenbefehle_Wege_Enum;

   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;

   StadtName : SystemRecords.TextEingabeRecord;

   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   type StandardStadtnameArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of StadtDatentypen.MaximaleStädte;
   StandardStadtname : StandardStadtnameArray := (others => StadtDatentypen.MaximaleStädte'First);

   procedure StadtEintragen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure WegAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );



   function StadtBaubar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function StadtnummerErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),

       Post => (
                  StadtnummerErmitteln'Result in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
               );

   function HauptstadtPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),

       Post => (
                  HauptstadtPrüfen'Result /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
               );

end StadtBauenLogik;
