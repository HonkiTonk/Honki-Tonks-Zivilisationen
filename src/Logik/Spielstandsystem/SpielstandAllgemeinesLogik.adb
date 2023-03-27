with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with TextKonstanten;

with TexteingabeLogik;
with NachGrafiktask;

package body SpielstandAllgemeinesLogik is

   function SpielstandNameErmitteln
     return Unbounded_Wide_Wide_String
   is begin
     
      NachGrafiktask.NameSpielstand := True;
      SpielstandName := TexteingabeLogik.SpielstandName;
      NachGrafiktask.NameSpielstand := False;
      
      case
        SpielstandName.ErfolgreichAbbruch
      is
         when True =>
            -- Es wird hier keine Prüfung benötigt ob die Namenslänge > 0 ist, da dies schon in TexteingabeLogik.SpielstandName geprüft wird.
            -- Die Prüfung ob der Name kurz genug für das Dateisystem ist erfolgt in TexteingabeGrafik.
            return SpielstandName.EingegebenerText;
            
         when False =>
            return TextKonstanten.LeerUnboundedString;
      end case;
            
   end SpielstandNameErmitteln;
   
   
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean
   is begin
      
      return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandnameExtern)));
      
   end SpielstandVorhanden;

end SpielstandAllgemeinesLogik;
