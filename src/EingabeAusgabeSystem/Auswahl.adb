pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with SystemKonstanten;

with Anzeige;
with Eingabe;

package body Auswahl is
   
   function Auswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural)
      return Integer
   is begin

      Anfang := ErsteZeileExtern;
      Ende := LetzteZeileExtern;
      AktuelleAuswahl := ErsteZeileExtern;

      AuswahlSchleife:
      loop

         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         
         Anzeige.AnzeigeMitAuswahlNeu (FrageDateiExtern      => FrageDateiExtern,
                                       TextDateiExtern       => TextDateiExtern,
                                       FrageZeileExtern      => FrageZeileExtern,
                                       ErsteZeileExtern      => ErsteZeileExtern,
                                       LetzteZeileExtern     => LetzteZeileExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahl);

         case
           Eingabe.Tastenwert
         is
            when SystemDatentypen.Oben =>
               if
                 AktuelleAuswahl = Anfang
               then
                  AktuelleAuswahl := Ende;

               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when SystemDatentypen.Unten =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anfang;

               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when SystemDatentypen.Auswählen =>
               -- Hauptmenü
               if
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 1)
               then
                  return SystemKonstanten.HauptmenüKonstante;
                  
                  -- Spiel beenden
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 2)
               then
                  return SystemKonstanten.SpielBeendenKonstante;
                  
                  -- Zurück
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 3)
               then
                  return SystemKonstanten.ZurückKonstante;
                  
                  -- Ja
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 4)
               then
                  return SystemKonstanten.JaKonstante;
                  
                  -- Nein
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 5)
               then
                  return SystemKonstanten.NeinKonstante;

                  -- Speichern
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 6)
               then
                  return SystemKonstanten.SpeichernKonstante;

                  -- Laden
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 7)
               then
                  return SystemKonstanten.LadenKonstante;

                  -- Optionen
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 8)
               then
                  return SystemKonstanten.OptionenKonstante;

                  -- Informationen
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 9)
               then
                  return SystemKonstanten.InformationenKonstante;

                  -- Wiederherstellen
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 10)
               then
                  return SystemKonstanten.WiederherstellenKonstante;

                  -- Würdigungen
               elsif
                 GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), AktuelleAuswahl) = GlobaleTexte.TexteEinlesenNeu (2, 11)
               then
                  return SystemKonstanten.WürdigungenKonstante;
                     
               else
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleAuswahl - ErsteZeileExtern + 1;
               end if;
                     
            when others =>
               null;
         end case;

      end loop AuswahlSchleife;
      
   end Auswahl;



   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return Integer
   is begin
      
      return Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                      TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                      FrageZeileExtern  => FrageZeileExtern,
                      ErsteZeileExtern  => SystemKonstanten.JaAnzeigeKonstante,
                      LetzteZeileExtern => SystemKonstanten.NeinAnzeigeKonstante);
      
   end AuswahlJaNein;

end Auswahl;
