with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;

with Fehlermeldungssystem;
with EinstellungenGrafik;

package body EinlesenGrafikeinstellungenLogik is

   -- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
   procedure Grafikeinstellungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.Grafikeinstellungen)
      is
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
            return;
            
         when True =>
            Open (File => DateiGrafikeinstellungen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.Grafikeinstellungen,
                  Form => "WCEM=8");
      end case;
      
      case
        GrafikeinstellungenDurchgehen (LadenPrüfenExtern => False,
                                       DateiLadenExtern  => DateiGrafikeinstellungen)
      is
         when True =>
            Set_Index (File => DateiGrafikeinstellungen,
                       To   => 1);
            
            Nullwert := GrafikeinstellungenDurchgehen (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiGrafikeinstellungen);
            
         when False =>
            EinstellungenGrafik.StandardeinstellungenLaden;
      end case;
      
      Close (File => DateiGrafikeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenGrafikeinstellungenLogik.Grafikeinstellungen - Konnte nicht geladen werden: " & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         EinstellungenGrafik.StandardeinstellungenLaden;
         
         case
           Is_Open (File => DateiGrafikeinstellungen)
         is
            when True =>
               Close (File => DateiGrafikeinstellungen);
               
            when False =>
               null;
         end case;
      
   end Grafikeinstellungen;
   
   
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
            
      case
        End_Of_File (File => DateiLadenExtern)
      is
         when True =>
            null;
            
         when False =>
            null;
      end case;
            
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenGrafikeinstellungenLogik.GrafikeinstellungenDurchgehen - Konnte nicht geladen werden: "
                                     & Decode (Item => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end GrafikeinstellungenDurchgehen;

end EinlesenGrafikeinstellungenLogik;
