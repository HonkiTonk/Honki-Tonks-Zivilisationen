pragma SPARK_Mode (On);

with GlobaleVariablen;
with SystemKonstanten;
with GlobaleTexte;

with SchreibenEinstellungen;
with EinlesenSprache;
with EinlesenText;

with AuswahlSprache;
with Eingabe;
with Auswahl;

package body OptionenSonstiges is

   function Sonstiges
     return Integer
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Leer,
                                         TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => SystemKonstanten.OptionenSonstigesErsteZeile,
                                         LetzteZeileExtern => SystemKonstanten.OptionenSonstigesLetzteZeile);

         case
           AuswahlWert
         is
            when 1 =>
               AnzahlAutomatischerSpielstände;
               
            when 2 =>
               RundenBisAutospeichern;
               
            when 3 =>
               SpracheWechseln;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               SchreibenEinstellungen.SchreibenEinstellungen;
               return AuswahlWert;
               
            when others =>
               null;
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                        ZeileExtern         => SystemKonstanten.OptionenSonstigesErsteZeile,
                                        ZahlenMinimumExtern => 0,
                                        ZahlenMaximumExtern => 999_999_999);
      case
        AuswahlWert
      is
         when 0 .. 999_999_999 =>
            GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := AuswahlWert;
            
         when others =>
            null;
      end case;
      
   end AnzahlAutomatischerSpielstände;
   
   
   
   procedure RundenBisAutospeichern
   is begin
      
      AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                        ZeileExtern         => SystemKonstanten.OptionenSonstigesErsteZeile + 1,
                                        ZahlenMinimumExtern => 1,
                                        ZahlenMaximumExtern => 999_999_999);

      case
        AuswahlWert
      is
         when 1 .. 999_999_999 =>
            GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave := AuswahlWert;
                     
         when others =>
            null;
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      case
        EinlesenSprache.EinlesenSprache
      is
         when True =>
            GlobaleVariablen.NutzerEinstellungen.Sprache := AuswahlSprache.AuswahlSprache;
            -- Kann hier noch Müll einlesen und Absturz erzeugen.
            Erfolgreich := EinlesenText.EinlesenTextNeu;
            
         when False =>
            null;
      end case;
      
   end SpracheWechseln;

end OptionenSonstiges;
