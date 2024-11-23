with Ada.Directories; use Ada.Directories;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;

with UmwandlungssystemHTB3;
with MeldungssystemHTB1;

package body SchreibenVerzeichnisseLogik is

   procedure Verzeichnisse
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Spielstand)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Spielstand);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandSpieler)
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandSpieler);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandAuto)
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.SpielstandStrich & VerzeichnisKonstanten.SpielstandAuto);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.Datenbanken)
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Datenbanken);
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.Einstellungen)
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => VerzeichnisKonstanten.Einstellungen);
      end case;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenVerzeichnisseLogik.Verzeichnisse: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
   end Verzeichnisse;

end SchreibenVerzeichnisseLogik;
