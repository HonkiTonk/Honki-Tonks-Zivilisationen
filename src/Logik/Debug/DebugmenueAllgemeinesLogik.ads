with SpeziesDatentypen;
with SystemRecords;
with DiplomatieDatentypen;

with LeseSpeziesbelegung;

package DebugmenueAllgemeinesLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function SpeziesAuswählen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpeziesDatentypen.Spezies_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function DiplomatiestatusAuswählen
     return DiplomatieDatentypen.Status_Untereinander_Enum;
   
private
   
   AusgewählteSpezies : SpeziesDatentypen.Spezies_Vorhanden_Enum;

   Zahleneingabe : SystemRecords.ZahlenEingabeRecord;

end DebugmenueAllgemeinesLogik;
