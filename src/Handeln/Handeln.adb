pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;

with Auswahl, Sichtbarkeit, KennenLernen, Eingabe, DiplomatischerZustand;

package body Handeln is

   function Handelsmenü
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
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
                                            LetzteZeileExtern => 10);
      
         case
           AuswahlHandeln
         is
            when 1 =>
               -- Karten tauschen
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => 0);
               
            when 2 =>
               -- Karten kaufen
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => -1);
               
            when 3 =>
               -- Karten verkaufen
               Sichtbarkeit.SichtbarkeitHandel (RasseEinsExtern     => RasseExtern,
                                                RasseZweiExtern     => KontaktierteRasseExtern,
                                                WelcherHandelExtern => 1);
               
            when 4 =>
               -- Kontakte tauschen
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => 0);
               
            when 5 =>
               -- Kontakte kaufen
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => -1);
               
            when 6 =>
               -- Kontakte verkaufen
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern,
                                 WelcherHandelExtern     => 1);
               
            when 7 =>
               -- Geld verschenken
               if
                 LeseWichtiges.Geldmenge (RasseExtern => RasseExtern) >= Positive'First
               then
                  Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
                                                  ZeileExtern         => 11,
                                                  ZahlenMinimumExtern => 0,
                                                  ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
               
                  SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                               GeldZugewinnExtern  => -Geldmenge,
                                               RechnenSetzenExtern => True);
               
                  SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                               GeldZugewinnExtern  => Geldmenge,
                                               RechnenSetzenExtern => True);
                  
                  if
                    Geldmenge / 25 > Integer (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                             FremdeRasseExtern => RasseExtern,
                                                             ÄnderungExtern   => GlobaleDatentypen.ProduktionFeld'Last);
                     
                  else
                     DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                             FremdeRasseExtern => RasseExtern,
                                                             ÄnderungExtern   => GlobaleDatentypen.ProduktionFeld (Geldmenge / 25));
                  end if;
                  
               else
                  null;
               end if;
               
            when 8 =>
               -- Geld verlangen
               if
                 LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern) >= Positive'First
               then
                  Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
                                                  ZeileExtern         => 12,
                                                  ZahlenMinimumExtern => 0,
                                                  ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern));
               
                  SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                               GeldZugewinnExtern  => Geldmenge,
                                               RechnenSetzenExtern => True);
               
                  SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                               GeldZugewinnExtern  => -Geldmenge,
                                               RechnenSetzenExtern => True);
                  
                  if
                    Geldmenge / 25 > Integer (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                             FremdeRasseExtern => RasseExtern,
                                                             ÄnderungExtern   => -GlobaleDatentypen.ProduktionFeld'Last);
                     
                  else
                     DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                             FremdeRasseExtern => RasseExtern,
                                                             ÄnderungExtern   => -GlobaleDatentypen.ProduktionFeld (Geldmenge / 25));
                  end if;
                  
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
                     GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseEinsSchleifenwert).AktuellerZustand = GlobaleDatentypen.Unbekannt
                 or
                   GlobaleVariablen.Diplomatie (RasseExtern, RasseEinsSchleifenwert).AktuellerZustand /= GlobaleDatentypen.Unbekannt
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
                     GlobaleVariablen.Diplomatie (RasseExtern, RasseZweiSchleifenwert).AktuellerZustand = GlobaleDatentypen.Unbekannt
                 or
                   GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseZweiSchleifenwert).AktuellerZustand /= GlobaleDatentypen.Unbekannt
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
