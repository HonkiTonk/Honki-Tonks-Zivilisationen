pragma SPARK_Mode (On);

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with SystemDatentypen; use SystemDatentypen;
with SystemKonstanten;
with GlobaleTexte;

with Eingabe;
with Auswahl;
with Anzeige;
with SchreibenTastatur;
with EingabeSFML;

package body OptionenSteuerung is

   function SteuerungBelegen
     return Integer
   is begin
      
      BelegungSchleife:
      loop
         
         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Fragen,
                                         TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                                         FrageZeileExtern  => 28,
                                         ErsteZeileExtern  => 22,
                                         LetzteZeileExtern => 66);
         
         case
           AuswahlWert
         is
            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante | SystemKonstanten.ZurückKonstante =>
               return AuswahlWert;
               
            when SystemKonstanten.SpeichernKonstante =>
               SchreibenTastatur.TastenbelegungSchreiben;
               
            when SystemKonstanten.WiederherstellenKonstante =>
               Eingabe.StandardTastenbelegungLaden;
               SchreibenTastatur.TastenbelegungSchreiben;
                     
            when others =>
               AlteTasteEntfernen;
         end case;
         
         NeueTasteFestlegen;
         
      end loop BelegungSchleife;
      
   end SteuerungBelegen;
   
   
   
   procedure AlteTasteEntfernen
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 46,
                                     LetzteZeileExtern      => 46,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
               
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (AuswahlWert);
               
      -- Put_Line (Eingabe.Tastenbelegung (1, NeueAuswahl) & "    " & Eingabe.Tastenbelegung (2, NeueAuswahl));
               
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Fragen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 29,
                                     LetzteZeileExtern      => 29,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
               
      NeueTaste := EingabeSFML.TastenEingabe;
               
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
            if
              Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) = NeueTaste
              and
                BelegungPositionSchleifenwert /= NeueAuswahl
            then
               Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
               exit BelegungFeldSchleife;
               
            else
               null;
            end if;
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;
      
   end AlteTasteEntfernen;
   
   
   
   procedure NeueTasteFestlegen
   is begin
      
      NeueAuswahl := SystemDatentypen.Tastenbelegung_Enum'Val (AuswahlWert);
         
      if
        Eingabe.Tastenbelegung (1, NeueAuswahl) = NeueTaste
        or
          Eingabe.Tastenbelegung (2, NeueAuswahl) = NeueTaste
      then
         null;
            
      elsif
        Eingabe.Tastenbelegung (1, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
      then
         Eingabe.Tastenbelegung (1, NeueAuswahl) := NeueTaste;
            
      elsif
        Eingabe.Tastenbelegung (2, NeueAuswahl) = Sf.Window.Keyboard.sfKeyUnknown
      then
         Eingabe.Tastenbelegung (2, NeueAuswahl) := NeueTaste;
            
      else
         Eingabe.Tastenbelegung (2, NeueAuswahl) := Eingabe.Tastenbelegung (1, NeueAuswahl);
         Eingabe.Tastenbelegung (1, NeueAuswahl) := NeueTaste;
      end if;
      
   end NeueTasteFestlegen;

end OptionenSteuerung;
