pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with GrafikDatentypen;
with OptionenVariablen;
with MenueDatentypen;

with Eingabe;
with AuswahlMenues;
with SchreibenTastatur;
with EingabeTerminal;
with EingabeSFML;
with Fehler;
with RueckgabeMenues;

package body OptionenSteuerung is

   function SteuerungBelegen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      BelegungSchleife:
      loop
                  
         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Steuerung_Menü_Enum);
         
         case
           AuswahlWert
         is   
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when RueckgabeDatentypen.Wiederherstellen_Enum =>
               Eingabe.StandardTastenbelegungLaden;
               SchreibenTastatur.TastenbelegungSchreiben;
            
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               return AuswahlWert;
               
            when RueckgabeDatentypen.Eingabe_Enum =>
               AlteTasteEntfernen;
                     
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSteuerung.SteuerungBelegen - Falsche Menüauswahl.");
         end case;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;
   
   
   
   procedure AlteTasteEntfernen
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            AlteTasteEntfernenTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            AlteTasteEntfernenSFML;
      end case;
      
   end AlteTasteEntfernen;
   
   
   
   procedure AlteTasteEntfernenTerminal
   is begin
      
      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 46,
      --                                          LetzteZeileExtern      => 46,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
               
      NeueAuswahl := TastenbelegungDatentypen.Tastenbelegung_Enum'Val (1);
               
      Put_Line (Item => EingabeTerminal.Tastenbelegung (1, NeueAuswahl) & "    " & EingabeTerminal.Tastenbelegung (2, NeueAuswahl));
               
      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Fragen,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 29,
      --                                          LetzteZeileExtern      => 29,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      NeueTasteTerminal := EingabeTerminal.TastenEingabe;
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in EingabeTerminal.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in EingabeTerminal.TastenbelegungArray'Range (2) loop
            
            if
              EingabeTerminal.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTasteTerminal
              and
                BelegungPositionSchleifenwert /= NeueAuswahl
            then
               EingabeTerminal.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := NUL;
               exit BelegungFeldSchleife;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
   end AlteTasteEntfernenTerminal;
   
   
   
   procedure AlteTasteEntfernenSFML
   is begin
               
      NeueAuswahl := TastenbelegungDatentypen.Tastenbelegung_Enum'Val (RueckgabeMenues.UmbelegungNummer);
      -- Das hier später entfernen.
      Put_Line (Item => NeueAuswahl'Wide_Wide_Image);
      
      NeueTasteSchleife:
      loop
         
         -- Hier nicht mehr direkt darauf zugreifen sondern so wie in allen anderen Menüs. äöü
         -- EingabeSystemeSFML.TastenEingabe; äöü
         -- NeueTasteSFML := EingabeSystemeSFML.TastaturTaste; äöü
         
         case
           NeueTasteSFML
         is
            when Sf.Window.Keyboard.sfKeyUnknown =>
               null;
               
            when Sf.Window.Keyboard.sfKeyEscape =>
               return;
               
            when others =>
               exit NeueTasteSchleife;
         end case;
         
      end loop NeueTasteSchleife;
               
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in EingabeSFML.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in EingabeSFML.TastenbelegungArray'Range (2) loop
            
            if
              EingabeSFML.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTasteSFML
              and
                BelegungPositionSchleifenwert /= NeueAuswahl
            then
               EingabeSFML.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
      NeueTasteFestlegen;
      
   end AlteTasteEntfernenSFML;
   
   
   
   procedure NeueTasteFestlegen
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            AlteTasteEntfernenTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            NeueTasteFestlegenSFML;
      end case;
      
   end NeueTasteFestlegen;
   
   
   
   procedure NeueTasteFestlegenTerminal
   is begin
      
      NeueAuswahl := TastenbelegungDatentypen.Tastenbelegung_Enum'Val (1);
         
      if
        EingabeTerminal.Tastenbelegung (1, NeueAuswahl) = NeueTasteTerminal
        or
          EingabeTerminal.Tastenbelegung (2, NeueAuswahl) = NeueTasteTerminal
      then
         null;
            
      elsif
        EingabeTerminal.Tastenbelegung (1, NeueAuswahl) = NUL
      then
         EingabeTerminal.Tastenbelegung (1, NeueAuswahl) := NeueTasteTerminal;
            
      elsif
        EingabeTerminal.Tastenbelegung (2, NeueAuswahl) = NUL
      then
         EingabeTerminal.Tastenbelegung (2, NeueAuswahl) := NeueTasteTerminal;
            
      else
         EingabeTerminal.Tastenbelegung (2, NeueAuswahl) := EingabeTerminal.Tastenbelegung (1, NeueAuswahl);
         EingabeTerminal.Tastenbelegung (1, NeueAuswahl) := NeueTasteTerminal;
      end if;
      
   end NeueTasteFestlegenTerminal;
   
   
   
   procedure NeueTasteFestlegenSFML
   is begin
         
      if
        EingabeSFML.Tastenbelegung (1, NeueAuswahl) = NeueTasteSFML
        or
          EingabeSFML.Tastenbelegung (2, NeueAuswahl) = NeueTasteSFML
      then
         null;
            
      elsif
        EingabeSFML.Tastenbelegung (1, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
      then
         EingabeSFML.Tastenbelegung (1, NeueAuswahl) := NeueTasteSFML;
            
      elsif
        EingabeSFML.Tastenbelegung (2, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
      then
         EingabeSFML.Tastenbelegung (2, NeueAuswahl) := NeueTasteSFML;
            
      else
         EingabeSFML.Tastenbelegung (2, NeueAuswahl) := EingabeSFML.Tastenbelegung (1, NeueAuswahl);
         EingabeSFML.Tastenbelegung (1, NeueAuswahl) := NeueTasteSFML;
      end if;
      
   end NeueTasteFestlegenSFML;

end OptionenSteuerung;
