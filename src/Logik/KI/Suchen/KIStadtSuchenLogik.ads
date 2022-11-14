with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;
with SpielVariablen;
with Weltkarte;

private with StadtDatentypen;

package KIStadtSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

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
   use type StadtDatentypen.MaximaleStädteMitNullWert;

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
                  StadtSuchen'Result <= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );

end KIStadtSuchenLogik;
