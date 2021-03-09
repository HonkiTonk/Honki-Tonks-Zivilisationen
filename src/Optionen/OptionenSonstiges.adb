pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;

with Auswahl, Eingabe;

package body OptionenSonstiges is

   function Sonstiges return Integer is
   begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Leer,
                                         TextDatei   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeile  => 0,
                                         ErsteZeile  => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                         LetzteZeile => GlobaleKonstanten.OptionenSonstigesLetzteZeile);

         case AuswahlWert is
            when 1 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Menü_Auswahl,
                                                 Zeile         => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                                 ZahlenMinimum => 0,
                                                 ZahlenMaximum => 999_999_999);
               case AuswahlWert is
                  when 0 .. 999_999_999 =>
                     GlobaleVariablen.AnzahlAutosave := AuswahlWert;
                        
                  when others =>
                     null;
               end case;                  
               
            when 2 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Menü_Auswahl,
                                                 Zeile         => GlobaleKonstanten.OptionenSonstigesErsteZeile + 1,
                                                 ZahlenMinimum => 0,
                                                 ZahlenMaximum => 999_999_999);

               case AuswahlWert is
                  when 0 =>
                     GlobaleVariablen.RundenBisAutosave := 1;
                     
                  when 1 .. 999_999_999 =>
                     GlobaleVariablen.RundenBisAutosave := AuswahlWert;
                     
                  when others =>
                     null;
               end case;
               
            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               null;
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;

end OptionenSonstiges;
