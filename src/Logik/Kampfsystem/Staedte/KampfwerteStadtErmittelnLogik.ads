with SpeziesDatentypen;
with KampfDatentypen;
with KartenverbesserungDatentypen;
with KartenRecords;
with StadtArrays;
with StadtDatentypen;
with SystemDatentypen;

with LeseSpeziesbelegung;

package KampfwerteStadtErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function AktuelleVerteidigungStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function AktuellerAngriffStadt
     (IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeExtern : in StadtArrays.GebäudeArray;
      EinwohnerExtern : in StadtDatentypen.EinwohnerVorhanden;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   type KampfwerteArray is array (SystemDatentypen.Task_Enum'Range) of KampfDatentypen.Kampfwerte;
   Verteidigung : KampfwerteArray;
   Angriff : KampfwerteArray;

end KampfwerteStadtErmittelnLogik;
