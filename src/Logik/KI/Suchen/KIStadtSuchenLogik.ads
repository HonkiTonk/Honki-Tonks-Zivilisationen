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
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function NähesteFeindlicheStadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AnfangKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 AnfangKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),

       Post => (
                  NähesteFeindlicheStadtSuchen'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  NähesteFeindlicheStadtSuchen'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

   function UnbewachteStadtSuchen
     (FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FeindlicheSpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              ),

       Post => (
                  UnbewachteStadtSuchen'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  UnbewachteStadtSuchen'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

private
   use type StadtDatentypen.Städtebereich;

   AktuelleStadt : StadtDatentypen.Städtebereich;
   GefundeneStadt : StadtDatentypen.Städtebereich;

   Entfernung : Natural;
   EntfernungNeu : Natural;

   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;



   function StadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AnfangKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtDatentypen.Städtebereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AnfangKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 AnfangKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),

       Post => (
                  StadtSuchen'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );

end KIStadtSuchenLogik;
