pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;

with Auswahl, Eingabe;

package body OptionenSonstiges is

   function Sonstiges return Integer is
   begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Leer,
                                         TextDatei   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeile  => 0,
                                         ErsteZeile  => 21,
                                         LetzteZeile => 24);

         case AuswahlWert is
            when 1 =>
               AuswahlWert := Eingabe.GanzeZahl (WelcheDatei   => 0,
                                                 WelcherText   => 0,
                                                 ZahlenMinimum => 0,
                                                 ZahlenMaximum => 999_999_999);
               case AuswahlWert is
                  when 0 .. 999_999_999 =>
                     GlobaleVariablen.AnzahlAutosave := AuswahlWert;
                        
                  when others =>
                     null;
               end case;                  
               
            when 2 =>
               AuswahlWert := Eingabe.GanzeZahl (WelcheDatei   => 0,
                                                 WelcherText   => 0,
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
               
            when 0 | -2 =>
               return AuswahlWert;
               
            when others =>
               null;
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;

end OptionenSonstiges;
