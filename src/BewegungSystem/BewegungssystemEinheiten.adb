package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) is
   begin

      Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      BewegenSchleife:
      loop
      
         Get_Immediate (Item => Richtung);
         Richtung := To_Lower (Item => Richtung);
              
         case Richtung is
            when 'w' | '8' =>
               YÄnderung := -1;
               XÄnderung := 0;
            
            when 'a' | '4' =>
               XÄnderung := -1;
               YÄnderung := 0;
            
            when 's' | '2' =>
               YÄnderung := 1;
               XÄnderung := 0;
            
            when 'd' | '6'  =>
               XÄnderung := 1;
               YÄnderung := 0;
            
            when '1' =>
               YÄnderung := 1;
               XÄnderung := -1;

            when '3' =>
               YÄnderung := 1;
               XÄnderung := 1;
            
            when '7' =>
               YÄnderung := -1;
               XÄnderung := -1;
            
            when '9' =>
               YÄnderung := -1;
               XÄnderung := 1;
            
            when others =>
               return;
         end case;
         
         BewegungEinheitenBerechnung (RasseExtern   => RasseExtern,
                                      EinheitNummer => EinheitNummer,
                                      YÄnderung     => YÄnderung,
                                      XÄnderung     => XÄnderung);
         Sichtbarkeit.Sichtbarkeitsprüfung (RasseExtern => RasseExtern);
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
            return;

         elsif Gewonnen = False then
            return;
               
         else
            Karte.AnzeigeKarte (RasseExtern => RasseExtern);
         end if;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;

   

   procedure BewegungEinheitenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) is
   begin

      Gewonnen := True;
      Angreifen := False; 
      
      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                        XKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse,
                                                        YÄnderung      => YÄnderung,
                                                        XÄnderung      => XÄnderung,
                                                        ZusatzYAbstand => 0);

      case KartenWert.YAchse is
         when GlobaleDatentypen.Kartenfeld'First =>
            return;
            
         when others =>
            if EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit = 3 then
               null;
               
            elsif EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit
              /= KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Passierbarkeit then
               case EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit is
                  when 2 =>
                     Stadtnummer := SchleifenPruefungen.KoordinatenStadtMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                                        YAchse       => KartenWert.YAchse,
                                                                                        XAchse       => KartenWert.XAchse);
         
                     case Stadtnummer is
                        when 0 =>
                           return;
               
                        when others =>
                           null;
                     end case;
                     
                  when others =>
                     return;
               end case;
            
            else
               null;
            end if;
      end case;

      GegnerEinheitWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => KartenWert.YAchse,
                                                                                  XAchse => KartenWert.XAchse);

      if GegnerEinheitWert.Rasse = RasseExtern then
         return;
                  
      else
         null;
      end if;

      GegnerStadtWert := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => KartenWert.YAchse,
                                                                              XAchse => KartenWert.XAchse);

      if GegnerStadtWert.Rasse = RasseExtern then
         GegnerStadtWert.Rasse := 0;
            
      else
         null;
      end if;      
      
      case GegnerEinheitWert.Platznummer is
         when SchleifenPruefungen.RückgabeWert | 0 =>
            null;
            
         when others =>
            BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasse   => RasseExtern,
                                                                     VerteidigendeRasse => GegnerEinheitWert.Rasse);
            case BereitsImKrieg is
               when 1 .. 2 =>
                  Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                              FrageDatei         => 10,
                                              FrageZeile         => 11,
                                              TextDatei          => 5,
                                              ErsteZeile         => 10,
                                              LetzteZeile        => 11);
                  case Wahl is
                     when -3 =>
                        Angreifen := True;
                        Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasse   => RasseExtern,
                                                              VerteidigendeRasse => GegnerEinheitWert.Rasse);
                     
                     when others =>
                        Angreifen := False;
                  end case;
                  
               when -1 =>
                  Angreifen := True;

               when others =>
                  Angreifen := False;
            end case;
         
            case Angreifen is
               when True =>
                  Gewonnen := Kampfsystem.KampfsystemNahkampf (GegnerStadtNummer           => GegnerStadtWert.Platznummer,
                                                               RasseAngriff                => RasseExtern,
                                                               EinheitenNummerAngriff      => EinheitNummer,
                                                               RasseVerteidigung           => GegnerEinheitWert.Rasse,
                                                               EinheitenNummerVerteidigung => GegnerEinheitWert.Platznummer);
               
               when False =>
                  return;
            end case;
      end case;
      
      case Gewonnen is
         when True =>
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße /= 0
              and Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße <= 19 then
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 0.50;

            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss /= 0 then
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 0.50;

            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße > 19 then   
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 1.00;

            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 1
              or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 7
              or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 9
              or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 32 then
               if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte < 1.00 then
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
                  return;
                     
               else                     
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 2.00;
               end if;
               
            else
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 1.00;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte < 0.00 then
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
                  
            else
               null;
            end if;

            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse := KartenWert.YAchse;
            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse := KartenWert.XAchse;               
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := KartenWert.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := KartenWert.XAchse;

            case Angreifen is
               when True =>
                  GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
                  
               when False =>
                  null;
            end case;
            
         when others =>
            null;
      end case;
                 
   end BewegungEinheitenBerechnung;

end BewegungssystemEinheiten;
