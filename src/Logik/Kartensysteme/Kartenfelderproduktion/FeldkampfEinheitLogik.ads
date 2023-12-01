with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;
with KampfDatentypen;
with SystemDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package FeldkampfEinheitLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum;
      KampfBasiswertExtern : in KampfDatentypen.KampfwerteEinheiten;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
   
   type KampfArray is array (SystemDatentypen.Task_Enum'Range) of KampfDatentypen.Kampfwerte;
   Gesamtwert : KampfArray;

end FeldkampfEinheitLogik;
