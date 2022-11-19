with RassenDatentypen;
with KartenDatentypen;
with KartenRecords;
with SpielVariablen;

private with StadtDatentypen;

with LeseWeltkarteneinstellungen;

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
                 AnfangKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),

       Post => (
                  NähesteFeindlicheStadtSuchen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  NähesteFeindlicheStadtSuchen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (FeindlicheRasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  UnbewachteStadtSuchen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  UnbewachteStadtSuchen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
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
                 AnfangKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),

       Post => (
                  StadtSuchen'Result <= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );

end KIStadtSuchenLogik;
