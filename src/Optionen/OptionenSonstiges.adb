pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;

with Auswahl, Eingabe;

package body OptionenSonstiges is

   function Sonstiges
     return Integer
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Leer,
                                         TextDateiExtern   => GlobaleDatentypen.Menü_Auswahl,
                                         FrageZeileExtern  => 0,
                                         ErsteZeileExtern  => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                         LetzteZeileExtern => GlobaleKonstanten.OptionenSonstigesLetzteZeile);

         case
           AuswahlWert
         is
            when 1 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Menü_Auswahl,
                                                 ZeileExtern         => GlobaleKonstanten.OptionenSonstigesErsteZeile,
                                                 ZahlenMinimumExtern => 0,
                                                 ZahlenMaximumExtern => 999_999_999);
               if
                 AuswahlWert
               in
                 0 .. 999_999_999
               then
                  GlobaleVariablen.AnzahlAutosave := AuswahlWert;
                        
               else
                  null;
               end if;                  
               
            when 2 =>
               AuswahlWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Menü_Auswahl,
                                                 ZeileExtern         => GlobaleKonstanten.OptionenSonstigesErsteZeile + 1,
                                                 ZahlenMinimumExtern=> 0,
                                                 ZahlenMaximumExtern => 999_999_999);

               if
                 AuswahlWert = 0
               then
                  GlobaleVariablen.RundenBisAutosave := 1;
                     
               elsif
                 AuswahlWert
               in
                 1 .. 999_999_999
               then
                  GlobaleVariablen.RundenBisAutosave := AuswahlWert;
                     
               else
                  null;
               end if;
               
            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               null;
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;

end OptionenSonstiges;
