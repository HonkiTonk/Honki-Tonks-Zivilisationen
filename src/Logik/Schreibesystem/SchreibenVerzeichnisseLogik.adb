with Ada.Directories; use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstantenHTSEB;

with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;

package body SchreibenVerzeichnisseLogik is

   procedure Verzeichnisse
   is begin
      
      case
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstand))
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstand));
      end case;
      
      case
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstandordner & VerzeichnisKonstantenHTSEB.SpielstandSpieler))
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstandordner & VerzeichnisKonstantenHTSEB.SpielstandSpieler));
      end case;
      
      case
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstandordner & VerzeichnisKonstantenHTSEB.SpielstandAuto))
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Spielstandordner & VerzeichnisKonstantenHTSEB.SpielstandAuto));
      end case;
      
      case
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Datenbanken))
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Datenbanken));
      end case;
      
      case
        Exists (Name => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Einstellungen))
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => UmwandlungssystemHTSEB.Encode (TextExtern => VerzeichnisKonstantenHTSEB.Einstellungen));
      end case;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenVerzeichnisseLogik.Verzeichnisse: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end Verzeichnisse;

end SchreibenVerzeichnisseLogik;
