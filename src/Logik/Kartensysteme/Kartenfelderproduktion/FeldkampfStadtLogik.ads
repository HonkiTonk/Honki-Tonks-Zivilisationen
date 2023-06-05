with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;
with KampfDatentypen;
with KartenverbesserungDatentypen;

private with KartengrundDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package FeldkampfStadtLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum;
      KampfBasiswertExtern : in KampfDatentypen.KampfwerteAllgemein;
      StadttypExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   Gesamtwert : KampfDatentypen.KampfwerteGroß;
   
   FeldeffekteVorhanden : KartenRecords.FeldeffektArray;

end FeldkampfStadtLogik;
