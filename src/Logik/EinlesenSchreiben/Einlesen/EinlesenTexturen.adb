pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Texture;

with Fehler;

package body EinlesenTexturen is
   
   procedure EinlesenTexturen
   is begin
            
      -- EinlesenHintergrundMenüs;
      EinlesenKartenfelder;
      EinlesenVerbesserungen;
      EinlesenEinheiten;
      EinlesenGebäude;
      
   end EinlesenTexturen;
   
   
   
   procedure EinlesenHintergrundMenüs
   is begin
      
      HintergrundSchleife:
      for HintergrundSchleifenwert in EingeleseneTexturenSFML.Hintergrund'Range loop
         
         case
           HintergrundSchleifenwert
         is
            when 1 =>
               EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
               
            when 2 =>
               EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) := Sf.Graphics.Texture.createFromFile (filename => "Grafik/Hintergrund/Hintergrund" & HintergrundSchleifenwert'Image & ".png");
         end case;
         
         if
           EingeleseneTexturenSFML.Hintergrund (HintergrundSchleifenwert) = null
         then
            Fehler.GrafikStopp (FehlermeldungExtern => "EinlesenTexturen.EinlesenHintergrundMenüs - EingeleseneTexturen.Hintergrund (HintergrundSchleifenwert) = null");
            
         else
            null;
         end if;
         
      end loop HintergrundSchleife;
      
   end EinlesenHintergrundMenüs;
   
   
   
   procedure EinlesenKartenfelder
   is begin
      
      case
        Exists (Name => "Grafik/Kartenfelder/0")
      is
         when False =>
            return;
            
         when True =>
            AktuelleZeile := 1;
            
            Open (File => DateiTextEinlesen,
                  Mode => In_File,
                  Name => "Grafik/Kartenfelder/0");
      end case;
      
      DateipfadeEinlesenSchleife:
      for DateipfadeEinlesenSchleifenwert in KartenfelderEinlesenArray'Range loop
         
         case
           VorzeitigesZeilenende (AktuelleZeileExtern => AktuelleZeile)
         is
            when True =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - Nicht genug Zeilen in der 0-Datei.");
               Close (File => DateiTextEinlesen);
               return;
               
            when False =>
               KartenfelderEinlesen (DateipfadeEinlesenSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiTextEinlesen));
         end case;
         
         AktuelleZeile := AktuelleZeile + 1;
         
      end loop DateipfadeEinlesenSchleife;
      
      Close (File => DateiTextEinlesen);
      
      TexturenZuweisenSchleife:
      for TexturenZuweisenSchleifenwert in EingeleseneTexturenSFML.KartenfelderAccessArray'Range loop
         
         case
           Exists (Name => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))))
         is
            when True =>
               EingeleseneTexturenSFML.KartenfelderAccess (TexturenZuweisenSchleifenwert)
                 := Sf.Graphics.Texture.createFromFile (filename => Encode (Item => To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert))));
                  
            when False =>
               Fehler.LogikMeldung (FehlermeldungExtern => "EinlesenTexturen.EinlesenKartenfelder - " & To_Wide_Wide_String (Source => KartenfelderEinlesen (TexturenZuweisenSchleifenwert)) & " fehlt.");
               EingeleseneTexturenSFML.KartenfelderAccess (TexturenZuweisenSchleifenwert) := null;
         end case;
         
      end loop TexturenZuweisenSchleife;
      
   end EinlesenKartenfelder;
   
   
   
   procedure EinlesenVerbesserungen
   is begin
      
      null;
      
   end EinlesenVerbesserungen;
   
   
   
   procedure EinlesenEinheiten
   is begin
      
      null;
      
   end EinlesenEinheiten;
   
   
   
   procedure EinlesenGebäude
   is begin
      
      null;
      
   end EinlesenGebäude;
   
   
   
   -- Allgemeine Einlesenfunktionen und -prozeduren bauen.
   -- DateiTextEinlesen auch über Extern machen.
   function VorzeitigesZeilenende
     (AktuelleZeileExtern : in Positive)
      return Boolean
   is begin
      
      case
        End_Of_File (File => DateiTextEinlesen)
      is
         when True =>
            return True;
               
         when False =>
            Set_Line (File => DateiTextEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (AktuelleZeileExtern));
            return False;
      end case;
      
   end VorzeitigesZeilenende;
   
end EinlesenTexturen;
