with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecordsHTSEB;

with SystemDatentypen;
with SpielRecords;
with SpeziesDatentypen;

package SpielstandAllgemeinesLogik is
   pragma Elaborate_Body;
      
   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean);
   
   procedure SpeziesbelegungSchreiben
     (SpeziesbelegungExtern : in SpielRecords.SpeziesbelegungArray);
   
   

   function SpielstandNameErmitteln
     return Unbounded_Wide_Wide_String;
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Boolean;
   
   function SpeziesbelegungLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpeziesDatentypen.Spieler_Enum;
   
   function SpeziesBesiegtLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     return Boolean;
   
   function GesamteSpeziesanzahl
     (SpeichernLadenExtern : in Boolean)
      return SpeziesDatentypen.Speziesnummern;
   
   function VorhandeneSpeziesanzahl
     (SpeichernLadenExtern : in Boolean)
      return SpeziesDatentypen.Speziesnummern;
   
private
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   SpielstandName : SystemRecordsHTSEB.TextEingabeRecord;

   Speziesbelegung : SpielRecords.SpeziesbelegungArray;

end SpielstandAllgemeinesLogik;
