pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with Auswahl, Sichtbarkeit, KennenLernen, Eingabe, WichtigesSetzen;

package body Handeln is

   function Handelsmenü
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern)
      is
         when GlobaleDatentypen.Krieg =>
            return 1;
            
         when others =>
            null;
      end case;
      
      HandelSchleife:
      loop
         
         AuswahlHandeln := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Handeln,
                                            TextDateiExtern   => GlobaleTexte.Handeln,
                                            FrageZeileExtern  => 1,
                                            ErsteZeileExtern  => 2,
                                            LetzteZeileExtern => 9);
      
         case
           AuswahlHandeln
         is
            when 1 =>
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => 0);
               
            when 2 =>
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => -1);
               
            when 3 =>
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => 1);
               
            when 4 =>
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => 0);
               
            when 5 =>
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => -1);
               
            when 6 =>
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => 1);
               
            when 7 =>
               if
                 GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge > 0
               then
                  Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
                                                  ZeileExtern         => 10,
                                                  ZahlenMinimumExtern => 0,
                                                  ZahlenMaximumExtern => GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge);
               
                  WichtigesSetzen.GeldFestlegen (RasseExtern        => RasseExtern,
                                                 GeldZugewinnExtern => -Geldmenge);
               
                  WichtigesSetzen.GeldFestlegen (RasseExtern        => KontaktierteRasseExtern,
                                                 GeldZugewinnExtern => Geldmenge);
                  
               else
                  null;
               end if;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return 1;
               
            when others =>
               null;
         end case;
         
      end loop HandelSchleife;
      
   end Handelsmenü;
   
   
   
   procedure KontakteTauschen
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcherHandelExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        WelcherHandelExtern
      is
         when -1 | 0 =>
            RassenEinsSchleife:
            for RasseEinsSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
               
               if
                 RasseEinsSchleifenwert = RasseExtern
                 or
                   RasseEinsSchleifenwert = KontaktierteRasseExtern
                   or
                     GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseEinsSchleifenwert) = GlobaleDatentypen.Unbekannt
                 or
                   GlobaleVariablen.Diplomatie (RasseExtern, RasseEinsSchleifenwert) /= GlobaleDatentypen.Unbekannt
               then
                  null;
                  
               else
                  KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                            FremdeRasseExtern => RasseEinsSchleifenwert);
               end if;
               
            end loop RassenEinsSchleife;
            
         when others =>
            null;
      end case;
      
      case
        WelcherHandelExtern
      is
         when 0 | 1 =>
            RassenZweiSchleife:
            for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
               
               if
                 RasseZweiSchleifenwert = RasseExtern
                 or
                   RasseZweiSchleifenwert = KontaktierteRasseExtern
                   or
                     GlobaleVariablen.Diplomatie (RasseExtern, RasseZweiSchleifenwert) = GlobaleDatentypen.Unbekannt
                 or
                   GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseZweiSchleifenwert) /= GlobaleDatentypen.Unbekannt
               then
                  null;
                  
               else
                  KennenLernen.Erstkontakt (EigeneRasseExtern => KontaktierteRasseExtern,
                                            FremdeRasseExtern => RasseZweiSchleifenwert);
               end if;
               
            end loop RassenZweiSchleife;
            
         when others =>
            null;
      end case;
      
   end KontakteTauschen;

end Handeln;
