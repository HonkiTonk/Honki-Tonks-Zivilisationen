with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with OptionenVariablen;

with SchreibeOptionen;

with Fehlermeldungssystem;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
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
      
      if
        LadenPrüfenExtern = False
      then
         -- SystemRecords.SonstigeEinstellungenRecord
         case
           End_Of_File (File => DateiLadenExtern)
         is
            when True =>
               return False;
            
            when False =>
               ZahlenDatentypen.EigenesPositive'Read (Stream (File => DateiLadenExtern),
                                                      Autospeichernwert);
         end case;
         -- SystemRecords.SonstigeEinstellungenRecord
      
      else
         SchreibeOptionen.GanzeSonstigeEinstellungen (EinstellungenExtern => (
                                                                              AktuellerAutospeichernwert => Autospeichernwert
                                                                             ));
      end if;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenSonstigeEinstellungenLogik.SonstigeEinstellungenDurchgehen - Konnte nicht geladen werden: "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SonstigeEinstellungenDurchgehen;

end EinlesenSonstigeEinstellungenLogik;
