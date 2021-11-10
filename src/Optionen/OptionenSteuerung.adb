pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;
with GlobaleTexte;
with GlobaleVariablen;

with Eingabe;
with AuswahlMenue;
with Anzeige;
with SchreibenTastatur;
with EingabeSystemeSFML;
with EingabeKonsole;
with EingabeSFML;

package body OptionenSteuerung is

   function SteuerungBelegen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      BelegungSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Steuerung_Menü);
         
         case
           AuswahlWert
         is   
            when SystemKonstanten.SpeichernKonstante =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when SystemKonstanten.WiederherstellenKonstante =>
               Eingabe.StandardTastenbelegungLaden;
               SchreibenTastatur.TastenbelegungSchreiben;
            
            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante | SystemKonstanten.ZurückKonstante =>
               return AuswahlWert;
                     
            when others =>
               AlteTasteEntfernen;
         end case;
         
         NeueTasteFestlegen;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;
   
   
   
   procedure AlteTasteEntfernen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            AlteTasteEntfernenKonsole;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            AlteTasteEntfernenSFML;
      end case;
      
   end AlteTasteEntfernen;
   
   
   
   procedure AlteTasteEntfernenKonsole
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 46,
                                     LetzteZeileExtern      => 46,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
               
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (1);
               
      Put_Line (EingabeKonsole.Tastenbelegung (1, NeueAuswahl) & "    " & EingabeKonsole.Tastenbelegung (2, NeueAuswahl));
               
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Fragen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 29,
                                     LetzteZeileExtern      => 29,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      NeueTasteKonsole := EingabeKonsole.TastenEingabe;
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in EingabeKonsole.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in EingabeKonsole.TastenbelegungArray'Range (2) loop
            
            if
              EingabeKonsole.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTasteKonsole
              and
                BelegungPositionSchleifenwert /= NeueAuswahl
            then
               EingabeKonsole.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := NUL;
               exit BelegungFeldSchleife;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
   end AlteTasteEntfernenKonsole;
   
   
   
   procedure AlteTasteEntfernenSFML
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 46,
                                     LetzteZeileExtern      => 46,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
               
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (1);
               
      -- Put_Line (Eingabe.Tastenbelegung (1, NeueAuswahl) & "    " & Eingabe.Tastenbelegung (2, NeueAuswahl));
               
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Fragen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 29,
                                     LetzteZeileExtern      => 29,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      EingabeSystemeSFML.TastenEingabe;
      NeueTasteSFML := EingabeSystemeSFML.TastaturTaste;
               
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
               exit BelegungFeldSchleife;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
   end AlteTasteEntfernenSFML;
   
   
   
   procedure NeueTasteFestlegen
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            AlteTasteEntfernenKonsole;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            NeueTasteFestlegenSFML;
      end case;
      
   end NeueTasteFestlegen;
   
   
   
   procedure NeueTasteFestlegenKonsole
   is begin
      
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (1);
         
      if
        EingabeKonsole.Tastenbelegung (1, NeueAuswahl) = NeueTasteKonsole
        or
          EingabeKonsole.Tastenbelegung (2, NeueAuswahl) = NeueTasteKonsole
      then
         null;
            
      elsif
        EingabeKonsole.Tastenbelegung (1, NeueAuswahl) = NUL
      then
         EingabeKonsole.Tastenbelegung (1, NeueAuswahl) := NeueTasteKonsole;
            
      elsif
        EingabeKonsole.Tastenbelegung (2, NeueAuswahl) = NUL
      then
         EingabeKonsole.Tastenbelegung (2, NeueAuswahl) := NeueTasteKonsole;
            
      else
         EingabeKonsole.Tastenbelegung (2, NeueAuswahl) := EingabeKonsole.Tastenbelegung (1, NeueAuswahl);
         EingabeKonsole.Tastenbelegung (1, NeueAuswahl) := NeueTasteKonsole;
      end if;
      
   end NeueTasteFestlegenKonsole;
   
   
   
   procedure NeueTasteFestlegenSFML
   is begin
      
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (1);
         
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
