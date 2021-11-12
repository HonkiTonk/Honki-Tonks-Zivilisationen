pragma SPARK_Mode (On);

with SystemKonstanten;
with GlobaleTexte;

with AuswahlMenue;
with GrafikAllgemein;
with Eingabe;

package body OptionenGrafik is

   function OptionenGrafik
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Grafik_Menü);
         
         case
           AuswahlWert
         is
            when SystemDatentypen.Auflösung_Ändern =>
               AuflösungÄndern;
            
            when SystemDatentypen.Farbtiefe_Ändern =>
               null;
               
            when SystemDatentypen.Bildrate_Ändern =>
               null;
               
            when SystemDatentypen.Schriftgröße =>
               null;
               
            when SystemKonstanten.ZurückKonstante | SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AuswahlWert;
               
            when others =>
               raise Program_Error;
         end case;
         
      end loop GrafikSchleife;
      
   end OptionenGrafik;
   
   
   
   procedure AuflösungÄndern
   is begin
      
      EingabeWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                        ZeileExtern         => 1,
                                        ZahlenMinimumExtern => 1,
                                        ZahlenMaximumExtern => 999_999_999);
      
      if
        EingabeWert > 0
      then
         NeueAuflösung.x := Sf.sfUint32 (EingabeWert);
           
      else
         return;
      end if;
      
      EingabeWert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Leer,
                                        ZeileExtern         => 1,
                                        ZahlenMinimumExtern => 1,
                                        ZahlenMaximumExtern => 999_999_999);
      
      if
        EingabeWert > 0
      then
         NeueAuflösung.y := Sf.sfUint32 (EingabeWert);
           
      else
         return;
      end if;
      
      GrafikAllgemein.FensterAuflösungÄndern (NeueAuflösungExtern => NeueAuflösung);
      
   end AuflösungÄndern;

end OptionenGrafik;
