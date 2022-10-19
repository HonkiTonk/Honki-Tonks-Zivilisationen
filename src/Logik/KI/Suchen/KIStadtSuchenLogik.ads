pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with SpielVariablen;

private with StadtDatentypen;

with Weltkarte;

package KIStadtSuchenLogik is

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),

       Post => (
                  NähesteFeindlicheStadtSuchen'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  NähesteFeindlicheStadtSuchen'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (FeindlicheRasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  UnbewachteStadtSuchen'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  UnbewachteStadtSuchen'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

private

   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert;
   GefundeneStadt : StadtDatentypen.MaximaleStädteMitNullWert;

   Entfernung : Positive;
   EntfernungNeu : Positive;

   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;



   function StadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),

       Post => (
                  StadtSuchen'Result in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );

end KIStadtSuchenLogik;