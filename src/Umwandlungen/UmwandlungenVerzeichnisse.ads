with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with SpielstandDatentypen;

package UmwandlungenVerzeichnisse is
   pragma Elaborate_Body;

   function Spielstandverzeichnis
     (SpielstandarteExtern : in SpielstandDatentypen.Spielstand_Enum)
      return String
     with
       Post => (
                  Spielstandverzeichnis'Result'Length > 0
               );
   
   function Spielstand
     (SpielstandarteExtern : in SpielstandDatentypen.Spielstand_Enum;
      SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return String
     with
       Pre => (
                 To_Wide_Wide_String (Source => SpielstandnameExtern)'Length > 0
              ),
         
       Post => (
                  Spielstandverzeichnis'Result'Length > 0
               );
   
private
   
   type VerzeichnisseArray is array (SpielstandDatentypen.Spielstand_Enum'Range) of Unbounded_Wide_Wide_String;
   Verzeichnisse : constant VerzeichnisseArray := (
                                                   SpielstandDatentypen.Manueller_Spielstand_Enum     => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                   & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandSpielerStrich),
                                                   SpielstandDatentypen.Automatischer_Spielstand_Enum => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                   & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandAutoStrich)
                                                  );

end UmwandlungenVerzeichnisse;
