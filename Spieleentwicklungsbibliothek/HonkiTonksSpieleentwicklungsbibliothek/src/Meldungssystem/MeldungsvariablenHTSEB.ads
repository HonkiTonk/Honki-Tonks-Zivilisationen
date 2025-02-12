package MeldungsvariablenHTSEB is
   pragma Preelaborate;

   procedure FehlerMeldungWechseln
     (FehlerMeldungExtern : in Boolean);
   pragma Inline (FehlerMeldungWechseln);
   
   procedure VersionsnummerWechseln
     (VersionsnummerExtern : in Wide_Wide_String)
     with
       Pre => (
                 VersionsnummerExtern'Length = 9
              );
   pragma Inline (VersionsnummerWechseln);
   
   
   
   function FehlerMeldungAbfragen
     return Boolean;
   pragma Inline (FehlerMeldungAbfragen);
   
   function VersionsnummerAbfragen
     return Wide_Wide_String
     with
       Post => (
                  VersionsnummerAbfragen'Result'Length = 9
               );
   pragma Inline (VersionsnummerAbfragen);
   
private
   
   FehlerMeldung : Boolean := True;
   
   Versionsnummer : Wide_Wide_String (1 .. 9) := "0.00.0000";

end MeldungsvariablenHTSEB;
