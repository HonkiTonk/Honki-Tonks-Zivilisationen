with SpeziesDatentypen;
with KartenRecords;
with KartenDatentypen;
with KampfDatentypen;
with KartenverbesserungDatentypen;
with SystemDatentypen;

with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package FeldkampfStadtLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function Feldkampf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum;
      KampfBasiswertExtern : in KampfDatentypen.KampfwerteEinheiten;
      StadttypExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
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

end FeldkampfStadtLogik;
