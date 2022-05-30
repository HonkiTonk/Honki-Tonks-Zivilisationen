pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SonstigeVariablen;
with KartenRecords;
with StadtDatentypen;
with SpielVariablen;

with Karten;

package KIStadtSuchen is

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            AnfangKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            AnfangKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse),

         Post =>
           (NähesteFeindlicheStadtSuchen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
            and
              NähesteFeindlicheStadtSuchen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (FeindlicheRasseExtern) = RassenDatentypen.Spieler_KI_Enum),

         Post =>
           (UnbewachteStadtSuchen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
            and
              UnbewachteStadtSuchen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

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
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            AnfangKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            AnfangKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse),

         Post =>
           (StadtSuchen'Result in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze);

end KIStadtSuchen;
