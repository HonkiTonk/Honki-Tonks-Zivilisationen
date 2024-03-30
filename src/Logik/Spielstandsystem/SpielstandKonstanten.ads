with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with VerzeichnisKonstanten;

with SpielstandDatentypen;

package SpielstandKonstanten is

   type VerzeichnisseArray is array (SpielstandDatentypen.Spielstand_Enum'Range) of Unbounded_Wide_Wide_String;
   Verzeichnisse : constant VerzeichnisseArray := (
                                                   SpielstandDatentypen.Manueller_Spielstand_Enum     => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                   & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandSpielerStrich),
                                                   SpielstandDatentypen.Automatischer_Spielstand_Enum => Decode (Item => VerzeichnisKonstanten.SpielstandStrich)
                                                   & To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.SpielstandAutoStrich)
                                                  );

end SpielstandKonstanten;
