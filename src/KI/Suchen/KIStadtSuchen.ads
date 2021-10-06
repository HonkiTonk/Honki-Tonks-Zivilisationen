pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;
with EinheitStadtDatentypen;

with Karten;

package KIStadtSuchen is

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer
          and
            AnfangKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AnfangKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (FeindlicheRasseExtern) = SonstigeDatentypen.Spieler_KI);

private

   AktuelleStadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   GefundeneStadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   Entfernung : Positive;
   EntfernungNeu : Positive;

   function StadtSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert;

end KIStadtSuchen;
