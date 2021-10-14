pragma SPARK_Mode (On);

with Sf.Graphics.Color;

with GrafikAllgemein;
with GrafikEinstellungen;

package body TextAnzeigeSFML is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural)
   is begin
      
      GrafikAllgemein.FensterLeeren;
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            ÜberschriftAbstand := 0;

         when others =>
            ÜberschriftAbstand := 1;
            GrafikAllgemein.TextZeichnen (PositionExtern    => StartAnzeigePosition,
                                          TextDateiExtern   => FrageDateiExtern,
                                          WelcheZeileExtern => FrageZeileExtern);
      end case;
            
      RahmenGezeichnet := False;
      AktuellePosition.x := StartAnzeigePosition.x;
      AktuelleZeile := 0;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
                  
         if
           AktuelleAuswahlExtern - ZeileSchleifenwert < -5
         then
            exit AnzeigeSchleife;
            
         elsif
           AktuelleAuswahlExtern - ZeileSchleifenwert > 5
         then
            null;
            
         else
            AnzeigeSelbst (TextDateiExtern             => TextDateiExtern,
                           AktuelleAuswahlExtern       => AktuelleAuswahlExtern,
                           MaximaleAnzahlZeichenExtern => MaximaleAnzahlZeichenExtern,
                           AktuelleZeileExtern         => ZeileSchleifenwert);
            
            AktuelleZeile := AktuelleZeile + 1;
         end if;
         
      end loop AnzeigeSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end AnzeigeMitAuswahl;
   
   
   
   procedure AnzeigeSelbst
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      AktuelleAuswahlExtern : in Positive;
      MaximaleAnzahlZeichenExtern : in Natural;
      AktuelleZeileExtern : in Natural)
   is begin
      
      AktuellePosition.y := StartAnzeigePosition.y + (Float (GrafikEinstellungen.Schriftgröße) + Zeilenabstand) * (Float (ÜberschriftAbstand + AktuelleZeile));
      
      if
        AktuelleAuswahlExtern = AktuelleZeileExtern
      then
         RahmenGezeichnet := True;
         Rahmenbreite := Float (GrafikEinstellungen.Schriftgröße) * 1.35;
         
         if
           Float (MaximaleAnzahlZeichenExtern * Positive (GrafikEinstellungen.Schriftgröße)) * 0.50 + AktuellePosition.x > Float (GrafikEinstellungen.FensterBreite)
         then
            Rahmenlänge := Float (GrafikEinstellungen.FensterBreite);
            
         else
            Rahmenlänge := Float (MaximaleAnzahlZeichenExtern * Positive (GrafikEinstellungen.Schriftgröße)) * 0.50;
         end if;
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmenlänge, Rahmendicke),
                                           PositionExtern  => AktuellePosition,
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmenlänge, Rahmendicke),
                                           PositionExtern  => (AktuellePosition.x, AktuellePosition.y + Rahmenbreite),
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmendicke, Rahmenbreite),
                                           PositionExtern  => AktuellePosition,
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         if
           AktuellePosition.x + Rahmenlänge - Rahmendicke > Float (GrafikEinstellungen.FensterBreite)
         then
            Position := Float (GrafikEinstellungen.FensterBreite);
            
         else
            Position := AktuellePosition.x + Rahmenlänge - Rahmendicke;
         end if;
         
         GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Rahmendicke, Rahmenbreite),
                                           PositionExtern  => (Position, AktuellePosition.y),
                                           FarbeExtern     => (Sf.Graphics.Color.sfWhite));
            
         AktuellePosition.x := StartAnzeigePosition.x + Rahmendicke + Rahmenabstand;
         
         GrafikAllgemein.TextZeichnen (PositionExtern    => AktuellePosition,
                                       TextDateiExtern   => TextDateiExtern,
                                       WelcheZeileExtern => AktuelleZeileExtern);
         
      else
         case
           RahmenGezeichnet
         is
            when True =>
               AktuellePosition.y := AktuellePosition.y + 2.00 * Rahmendicke;
                  
            when False =>
               null;
         end case;
         
         GrafikAllgemein.TextZeichnen (PositionExtern    => AktuellePosition,
                                       TextDateiExtern   => TextDateiExtern,
                                       WelcheZeileExtern => AktuelleZeileExtern);
      end if;
      
   end AnzeigeSelbst;
   
   
   
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
      
      null;
      
   end AnzeigeOhneAuswahl;

end TextAnzeigeSFML;
