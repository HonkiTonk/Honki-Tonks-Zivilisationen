with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

private with StadtDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

private with LeseGrenzen;

package KIStadtSuchenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function NähesteFeindlicheStadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
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
     (FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FeindlicheSpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
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

   Entfernung : Natural;
   EntfernungNeu : Natural;

   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;



   function StadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AnfangKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),

       Post => (
                  StadtSuchen'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );

end KIStadtSuchenLogik;
