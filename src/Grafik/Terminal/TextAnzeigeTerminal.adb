pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with TextKonstanten;
with GlobaleVariablen;
with GrafikDatentypen;

with Eingabe;
with TextAnzeigeTerminal;
with Fehler;

package body TextAnzeigeTerminal is

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
        NutzerEinstellungenVariablen.AnzeigeArt
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            TextAnzeigeTerminal.AnzeigeOhneAuswahl (ÜberschriftDateiExtern => ÜberschriftDateiExtern,
                                                   TextDateiExtern        => TextDateiExtern,
                                                   ÜberschriftZeileExtern => ÜberschriftZeileExtern,
                                                   ErsteZeileExtern       => ErsteZeileExtern,
                                                   LetzteZeileExtern      => LetzteZeileExtern,
                                                   AbstandAnfangExtern    => AbstandAnfangExtern,
                                                   AbstandMitteExtern     => AbstandMitteExtern,
                                                   AbstandEndeExtern      => AbstandEndeExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "Anzeige.AnzeigeOhneAuswahlNeu - SFML in Terminal aufgerufen.");
      end case;
      
   end AnzeigeOhneAuswahlNeu;



   procedure EinzeiligeAnzeigeOhneAuswahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextZeileExtern : in Positive)
   is begin
      
      case
        NutzerEinstellungenVariablen.AnzeigeArt
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
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
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "Anzeige.EinzeiligeAnzeigeOhneAuswahl - SFML in Terminal aufgerufen.");
      end case;
      
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
        NutzerEinstellungenVariablen.AnzeigeArt
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            TextAnzeigeTerminal.AnzeigeMitAuswahl (FrageDateiExtern            => FrageDateiExtern,
                                                  TextDateiExtern             => TextDateiExtern,
                                                  FrageZeileExtern            => FrageZeileExtern,
                                                  ErsteZeileExtern            => ErsteZeileExtern,
                                                  LetzteZeileExtern           => LetzteZeileExtern,
                                                  AktuelleAuswahlExtern       => AktuelleAuswahlExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "Anzeige.AnzeigeMitAuswahlNeu - SFML in Terminal aufgerufen.");
      end case;
      
   end AnzeigeMitAuswahlNeu;
   
   
   
   procedure AllgemeineAnzeige
     (AktuelleAuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeichenSchleifenwert in AlgemeineAnzeigeTextArray'Range loop
         
         if
           AllgemeineAnzeigeText (ZeichenSchleifenwert).Text = TextKonstanten.LeerUnboundedString
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
                        
                     Put (Item => " ");
                        
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
              AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text = TextKonstanten.LeerUnboundedString
            then
               exit AnzeigeSchleife;
            
            else
               Put_Line (Item => To_Wide_Wide_String (Source => AllgemeineAnzeigeText (AnzeigeSchleifenwert).Text));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
      
   end AllgemeineAnzeige;

   

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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (ÜberschriftDateiExtern), ÜberschriftZeileExtern)));
      end case;
      
      TextAnzeigeTerminal.AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      ZeichengrenzenMultiplikator := 1;

      TextNeu := GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ErsteZeileExtern);
      
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

      TextAnzeigeTerminal.AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeLangerTextNeu;
   
   
   
   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      Überschrift (FrageDateiExtern => FrageDateiExtern,
                    FrageZeileExtern => FrageZeileExtern);
      
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
                  Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert))'Length loop
                     
                     Put (Item => " ");
                        
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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeMitAuswahl;
   
   
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      Überschrift (FrageDateiExtern => ÜberschriftDateiExtern,
                    FrageZeileExtern => ÜberschriftZeileExtern);

      AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      TextAnzeigeSchleife:
      for TextZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), TextZeileSchleifenwert)));
                  
         if
           ErsteZeileExtern = LetzteZeileExtern
           or
             AbstandMitteExtern = GlobaleTexte.Leer
         then
            null;
            
         elsif
           ErsteZeileExtern < LetzteZeileExtern
         then
            AbstandEinbauen (AbstandExtern => AbstandMitteExtern);

         else
            null;
         end if;

      end loop TextAnzeigeSchleife;
      
      AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeOhneAuswahl;
   
   
   
   procedure Überschrift
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural)
   is begin
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesen (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
      end case;
      
   end Überschrift;
   
   
   
   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        AbstandExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when GlobaleTexte.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleTexte.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleTexte.Neue_Zeile =>
            New_Line;
      end case;
      
   end AbstandEinbauen;

end TextAnzeigeTerminal;
