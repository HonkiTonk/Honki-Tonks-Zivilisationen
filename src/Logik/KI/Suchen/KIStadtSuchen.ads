pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with SpielVariablen;

private with StadtDatentypen;

with Karten;

package KIStadtSuchen is

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              ),

       Post => (
                  NähesteFeindlicheStadtSuchen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  NähesteFeindlicheStadtSuchen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (FeindlicheRasseExtern) = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  UnbewachteStadtSuchen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  UnbewachteStadtSuchen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );

private

   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert;
   GefundeneStadt : StadtDatentypen.MaximaleStädteMitNullWert;
   Entfernung : Positive;
   EntfernungNeu : Positive;

   function StadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              ),

       Post => (
                  StadtSuchen'Result in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );

end KIStadtSuchen;
