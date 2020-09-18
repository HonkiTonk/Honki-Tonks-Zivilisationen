package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (Rasse, EinheitNummer : in Integer) is -- Noch einen Gesamtloop einbauen für Bewegung?
   begin

      Karte.AnzeigeKarte;

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
         
         BewegungEinheitenBerechnung (Rasse         => Rasse,
                                      EinheitNummer => EinheitNummer,
                                      YÄnderung     => YÄnderung,
                                      XÄnderung     => XÄnderung);
         Sichtbarkeit.Sichtbarkeitsprüfung;
         
         if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte = 0.0 then
            return;
               
         else
            Karte.AnzeigeKarte;
         end if;
         
      end loop;
      
   end BewegungEinheitenRichtung;

   

   procedure BewegungEinheitenBerechnung (Rasse, EinheitNummer, YÄnderung, XÄnderung : in Integer) is
   begin

      Gewonnen := True;
      EinheitOderStadt := True;      
      
      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate => GlobaleVariablen.CursorImSpiel.YAchse,
                                                        XKoordinate => GlobaleVariablen.CursorImSpiel.XAchse,
                                                        YÄnderung   => YÄnderung,
                                                        XÄnderung   => XÄnderung);

      case KartenWert.YWert is
         when -1_000_000 =>
            return;
            
         when others =>
            if EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Passierbarkeit = 3 then
               null;
               
            elsif EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Passierbarkeit
              /= KartenDatenbank.KartenObjektListe (Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund).Passierbarkeit then
               case EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Passierbarkeit is
                  when 2 =>
                     Stadtnummer := SchleifenPruefungen.KoordinatenStadtMitRasseSuchen (Rasse  => Rasse,
                                                                                        YAchse => KartenWert.YWert,
                                                                                        XAchse => KartenWert.XWert);
         
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

      GegnerWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => KartenWert.YWert,
                                                                                  XAchse => KartenWert.XWert);

      if GegnerWert.Rasse = GlobaleVariablen.Rasse then
         return;
                  
      else
         EinheitOderStadt := True;
      end if;

      GegnerWert := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => KartenWert.YWert,
                                                                              XAchse => KartenWert.XWert);

      if GegnerWert.Rasse = GlobaleVariablen.Rasse then
         return;
            
      else
         EinheitOderStadt := False;
      end if;
      
      case GegnerWert.Rasse is
         when -1_000_000 =>
            null;
            
         when others =>
            BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasse   => Rasse,
                                                                     VerteidigendeRasse => GegnerWert.Rasse);
            case BereitsImKrieg is
               when 1 .. 2 =>
                  Wahl := Auswahl.Auswahl (WelcheAuswahl => 11, WelcherText => 18);
                  case Wahl is
                     when -3 =>
                        Angreifen := True;
                        Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasse => Rasse,
                                                              VerteidigendeRasse => GegnerWert.Rasse);
                     
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
                  Gewonnen := Kampfsystem.KampfsystemNahkampf (EinheitOderStadt => EinheitOderStadt,
                                                               RasseAngriff => Rasse,
                                                               EinheitenPositionAngriff => EinheitNummer,
                                                               RasseVerteidigung => GegnerWert.Rasse,
                                                               EinheitenPositionVerteidigung => GegnerWert.Platznummer);
               
               when False =>
                  return;
            end case;
      end case;
      
      case Gewonnen is
         when True =>
            if Karten.Karten (KartenWert.YWert, KartenWert.XWert).VerbesserungStraße /= 0 and Karten.Karten (KartenWert.YWert, KartenWert.XWert).VerbesserungStraße <= 19 then
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte - 0.5;

            elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss /= 0 then
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte - 0.5;

            elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).VerbesserungStraße > 19 then   
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte - 1.0;

            elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund = 1 or Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund = 7
              or Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund = 9 or Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund = 32 then
               if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte < 1.0 then
                  GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := 0.0;
                  return;
                     
               else                     
                  GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte - 2.0;
               end if;
               
            else
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte - 1.0;
            end if;

            if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte < 0.0 then
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte := 0.0;
                  
            else
               null;
            end if;

            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).YAchse := KartenWert.YWert;
            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).XAchse := KartenWert.XWert;               
            GlobaleVariablen.CursorImSpiel.YAchse := KartenWert.YWert;
            GlobaleVariablen.CursorImSpiel.XAchse := KartenWert.XWert;
            
         when others =>
            null;
      end case;
                 
   end BewegungEinheitenBerechnung;

end BewegungssystemEinheiten;
