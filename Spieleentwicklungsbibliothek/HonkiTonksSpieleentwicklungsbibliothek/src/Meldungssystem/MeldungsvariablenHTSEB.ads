package MeldungsvariablenHTSEB is
   pragma Preelaborate;

   procedure FehlerMeldungWechseln
     (FehlerMeldungExtern : in Boolean);
   pragma Inline (FehlerMeldungWechseln);
   
   procedure VersionsnummerWechseln
     (VersionsnummerExtern : in Wide_Wide_String)
     with
       Pre => (
                 VersionsnummerExtern'Length = 22
              );
   pragma Inline (VersionsnummerWechseln);
   
   
   
   function FehlerMeldungAbfragen
     return Boolean;
   pragma Inline (FehlerMeldungAbfragen);
   
   function VersionsnummerAbfragen
     return Wide_Wide_String
     with
       Post => (
                  VersionsnummerAbfragen'Result'Length = 22
               );
   pragma Inline (VersionsnummerAbfragen);
   
private
   
   FehlerMeldung : Boolean := True;
   Versionsnummer : Wide_Wide_String (1 .. 20) := "0.00.0000 | SFML 2.5";

end MeldungsvariablenHTSEB;
