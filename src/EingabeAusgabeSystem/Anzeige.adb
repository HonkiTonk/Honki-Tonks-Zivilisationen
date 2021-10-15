pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with SystemKonstanten;
with GlobaleVariablen;
with SystemDatentypen;

with Eingabe;
with TextAnzeigeKonsole;
with TextAnzeigeSFML;

package body Anzeige is

   procedure AnzeigeOhneAuswahlNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole | SystemDatentypen.Beides =>
            TextAnzeigeKonsole.AnzeigeOhneAuswahl (ÜberschriftDateiExtern => ÜberschriftDateiExtern,
                                                   TextDateiExtern        => TextDateiExtern,
                                                   ÜberschriftZeileExtern => ÜberschriftZeileExtern,
                                                   ErsteZeileExtern       => ErsteZeileExtern,
                                                   LetzteZeileExtern      => LetzteZeileExtern,
                                                   AbstandAnfangExtern    => AbstandAnfangExtern,
                                                   AbstandMitteExtern     => AbstandMitteExtern,
                                                   AbstandEndeExtern      => AbstandEndeExtern);
            
         when SystemDatentypen.SFML =>
            null;
      end case;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            TextAnzeigeSFML.AnzeigeOhneAuswahl (ÜberschriftDateiExtern => ÜberschriftDateiExtern,
                                                TextDateiExtern        => TextDateiExtern,
                                                ÜberschriftZeileExtern => ÜberschriftZeileExtern,
                                                ErsteZeileExtern       => ErsteZeileExtern,
                                                LetzteZeileExtern      => LetzteZeileExtern,
                                                AbstandAnfangExtern    => AbstandAnfangExtern,
                                                AbstandMitteExtern     => AbstandMitteExtern,
                                                AbstandEndeExtern      => AbstandEndeExtern);
            
         when SystemDatentypen.Konsole =>
            null;
      end case;
        
      
      
   end AnzeigeOhneAuswahlNeu;



   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => TextDateiExtern,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => TextZeileExtern,
                                     LetzteZeileExtern      => TextZeileExtern,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);

      if
        TextDateiExtern = GlobaleTexte.Fehlermeldungen
        and
          TextZeileExtern /= 16
      then
         Eingabe.WartenEingabe;
            
      else
         null;
      end if;
      
   end EinzeiligeAnzeigeOhneAuswahl;



   procedure AnzeigeMitAuswahlNeu
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole | SystemDatentypen.Beides =>
            TextAnzeigeKonsole.AnzeigeMitAuswahl (FrageDateiExtern            => FrageDateiExtern,
                                                  TextDateiExtern             => TextDateiExtern,
                                                  FrageZeileExtern            => FrageZeileExtern,
                                                  ErsteZeileExtern            => ErsteZeileExtern,
                                                  LetzteZeileExtern           => LetzteZeileExtern,
                                                  AktuelleAuswahlExtern       => AktuelleAuswahlExtern);
            
         when SystemDatentypen.SFML =>
            null;
      end case;
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            TextAnzeigeSFML.AnzeigeMitAuswahl (FrageDateiExtern            => FrageDateiExtern,
                                               TextDateiExtern             => TextDateiExtern,
                                               FrageZeileExtern            => FrageZeileExtern,
                                               ErsteZeileExtern            => ErsteZeileExtern,
                                               LetzteZeileExtern           => LetzteZeileExtern,
                                               AktuelleAuswahlExtern       => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Konsole =>
            null;
      end case;
      
   end AnzeigeMitAuswahlNeu;
   
   
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitStadtDatentypen.MinimimMaximumID)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in AlgemeineAnzeigeTextArray'Range loop
         
         if
           To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text) = SystemKonstanten.LeerText
         then
            exit TextlängePrüfenSchleife;
            
         elsif
           To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text)'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => AllgemeineAnzeigeText (ZeichenSchleifenwert).Text)'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for AnzeigeSchleifenwert in AlgemeineAnzeigeTextArray'Range loop

         if
           AktuelleAuswahlExtern = AnzeigeSchleifenwert
         then
            RahmenEinsSchleife:
            for RahmenEinsSchleifenwert in 1 .. LängsterText loop
                  
               if
                 RahmenEinsSchleifenwert = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 RahmenEinsSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text));

                  LeererPlatzSchleife:
                  for LeererPlatzSchleifenwert in 1 .. LängsterText - To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text)'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;
                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenEinsSchleife;

            RahmenZweiSchleife:
            for RahmenZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 RahmenZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenZweiSchleife;
         
         else
            if
              To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text) = SystemKonstanten.LeerText
            then
               exit AnzeigeSchleife;
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AllgemeineAnzeige;

   

   procedure AnzeigeSprache
     (AktuelleAuswahlExtern : in Positive;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop

         if
           AktuelleAuswahlExtern = ZeileSchleifenwert
         then
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if
                 TextlängeEins = 1
               then
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 TextlängeEins = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert))'Length loop
                        
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenTeilEinsSchleife;

            RahmenTeilZweiSchleife:
            for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 TextlängeZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenTeilZweiSchleife;
         
         else
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.SprachenEinlesen (ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeSprache;

   

   procedure AnzeigeLangerTextNeu
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        ÜberschriftDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;
            
         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;
      
      TextAnzeigeKonsole.AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      ZeichengrenzenMultiplikator := 1;

      TextNeu := GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ErsteZeileExtern);
      
      AnzeigeSchleife:
      for ZeichenSchleifenwert in To_Wide_Wide_String (Source => TextNeu)'Range loop
         
         if
           To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert) = '|'
         then
            exit AnzeigeSchleife;
            
         elsif
           ZeichenSchleifenwert - Zeichengrenze * ZeichengrenzenMultiplikator > 1
         then
            if
              To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert) = ' '
            then
               ZeichengrenzenMultiplikator := ZeichengrenzenMultiplikator + 1;
               New_Line;
               
            else
               Put (Item => To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert));
            end if;
            
         else
            Put (Item => To_Wide_Wide_String (Source => TextNeu) (ZeichenSchleifenwert));
         end if;
         
      end loop AnzeigeSchleife;

      TextAnzeigeKonsole.AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeLangerTextNeu;

end Anzeige;
