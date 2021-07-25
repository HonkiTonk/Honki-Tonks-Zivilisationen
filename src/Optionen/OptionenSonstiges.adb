pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten, GlobaleTexte;

with Auswahl, Eingabe, SchreibenEinstellungen, EinlesenSprache, EinlesenText;

package body OptionenSonstiges is

   function Sonstiges
     return Integer
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Leer,
                                         TextDateiExtern   => GlobaleTexte.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                         LetzteZeileExtern => GlobaleKonstanten.OptionenSonstigesLetzteZeile);

         case
           AuswahlWert
         is
            when 1 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                                 ZeileExtern         => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                                 ZahlenMinimumExtern => 0,
                                                 ZahlenMaximumExtern => 999_999_999);
               if
                 AuswahlWert
               in
                 0 .. 999_999_999
               then
                  GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave := AuswahlWert;
                        
               else
                  null;
               end if;                  
               
            when 2 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Menü_Auswahl,
                                                 ZeileExtern         => GlobaleKonstanten.OptionenSonstigesErsteZeile + 1,
                                                 ZahlenMinimumExtern=> 1,
                                                 ZahlenMaximumExtern => 999_999_999);

               if
                 AuswahlWert
               in
                 1 .. 999_999_999
               then
                  GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave := AuswahlWert;
                     
               else
                  null;
               end if;
               
            when 3 =>
               Erfolgreich := EinlesenSprache.EinlesenSprache;
               
               if
                 Erfolgreich
               then
                  GlobaleVariablen.NutzerEinstellungen.Sprache := Auswahl.AuswahlSprache;
                  -- Kann hier noch Müll einlesen und Absturz erzeugen
                  Erfolgreich := EinlesenText.EinlesenTextNeu;
                  
               else
                  null;
               end if;
               
            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               SchreibenEinstellungen.SchreibenEinstellungen;
               return AuswahlWert;
               
            when others =>
               null;
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;

end OptionenSonstiges;
