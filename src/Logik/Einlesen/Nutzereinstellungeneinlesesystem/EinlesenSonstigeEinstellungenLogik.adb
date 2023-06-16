with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with OptionenVariablen;

with Fehlermeldungssystem;

package body EinlesenSonstigeEinstellungenLogik is

   procedure SonstigeEinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.SonstigeEinstellungen)
      is
         when False =>
            OptionenVariablen.SonstigeStandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiSonstigeEinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SonstigeEinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        SonstigeEinstellungenDurchgehen (LadenPrüfenExtern => False,
                                         DateiLadenExtern  => DateiSonstigeEinstellungen)
      is
         when True =>
            Set_Index (File => DateiSonstigeEinstellungen,
                       To   => 1);
            
            Nullwert := SonstigeEinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                         DateiLadenExtern  => DateiSonstigeEinstellungen);
            
         when False =>
            OptionenVariablen.SonstigeStandardeinstellungenLaden;
      end case;
      
      Close (File => DateiSonstigeEinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSonstigeEinstellungenLogik.SonstigeEinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         OptionenVariablen.SonstigeStandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiSonstigeEinstellungen)
         is
            when True =>
               Close (File => DateiSonstigeEinstellungen);
               
            when False =>
               null;
         end case;
      
   end SonstigeEinstellungen;
   
   
   
   function SonstigeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SystemRecords.SonstigeEinstellungenRecord'Read (Stream (File => DateiLadenExtern),
                                                      ZwischenspeicherSonstigeEinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            OptionenVariablen.SonstigeEinstellungen := ZwischenspeicherSonstigeEinstellungen;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSonstigeEinstellungenLogik.SonstigeEinstellungenDurchgehen - Konnte nicht geladen werden: "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SonstigeEinstellungenDurchgehen;

end EinlesenSonstigeEinstellungenLogik;
