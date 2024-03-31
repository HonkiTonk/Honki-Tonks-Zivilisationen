with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;
with SystemDatentypen;

package UmwandlungenVerzeichnisse is
   pragma Elaborate_Body;

   function Verzeichnispfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum)
      return String
     with
       Post => (
                  Verzeichnispfad'Result'Length > 0
               );
   
   function Spielstandpfad
     (SpielstandarteExtern : in SystemDatentypen.Spielstand_Enum;
      SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return String
     with
       Pre => (
                 To_Wide_Wide_String (Source => SpielstandnameExtern)'Length > 0
              ),
         
       Post => (
                  Spielstandpfad'Result'Length > 0
               );
   
private
   
   type VerzeichnisseArray is array (SystemDatentypen.Spielstand_Enum'Range) of Unbounded_Wide_Wide_String;
   Verzeichnispfade : constant VerzeichnisseArray := (
                                                      SystemDatentypen.Manueller_Spielstand_Enum     => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                      & To_Unbounded_Wide_Wide_String (Source => Decode (Item => VerzeichnisKonstanten.SpielstandSpieler)),
                                                   
                                                      SystemDatentypen.Automatischer_Spielstand_Enum => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                      & To_Unbounded_Wide_Wide_String (Source => Decode (Item => VerzeichnisKonstanten.SpielstandAuto))
                                                     );
   
   Spielstandpfade : constant VerzeichnisseArray := (
                                                     SystemDatentypen.Manueller_Spielstand_Enum     => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                     & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandSpielerStrich),
                                                   
                                                     SystemDatentypen.Automatischer_Spielstand_Enum => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                     & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandAutoStrich)
                                                    );

end UmwandlungenVerzeichnisse;
