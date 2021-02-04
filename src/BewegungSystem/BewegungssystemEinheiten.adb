with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with SchleifenPruefungen, GlobaleVariablen, KartenDatenbank, Karte, EinheitenDatenbank, Diplomatie, Sichtbarkeit;

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
         
         RückgabeWert := ZwischenEbene (RasseExtern   => RasseExtern,
                                         EinheitNummer => EinheitNummer,
                                         YÄnderung     => YÄnderung,
                                         XÄnderung     => XÄnderung);

         case RückgabeWert is
            when 1 => -- Bewegung auf Feld möglich.
               BewegungEinheitenBerechnung (RasseExtern   => RasseExtern,
                                            EinheitNummer => EinheitNummer,
                                            YPosition     => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse + YÄnderung,
                                            XPosition     => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse + XÄnderung);
               Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (RasseExtern   => RasseExtern,
                                                              EinheitNummer => EinheitNummer);
               
               
            when  0 => -- Außerhalb der Karte oder Feld blockiert durch eigene Einheit.
               null;

            when -1 => -- Gegnerische Einheit oder Stadt auf dem Feld.
               ErgebnisGegnerAngreifen := Diplomatie.GegnerAngreifenOderNicht (RasseExtern   => RasseExtern,
                                                                               EinheitNummer => EinheitNummer,
                                                                               Gegner        => GegnerWert);

               case ErgebnisGegnerAngreifen is
                  when True =>
                     BewegungEinheitenBerechnung (RasseExtern   => RasseExtern,
                                                  EinheitNummer => EinheitNummer,
                                                  YPosition     => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse + YÄnderung,
                                                  XPosition     => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse + XÄnderung);
                     Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (RasseExtern   => RasseExtern,
                                                                    EinheitNummer => EinheitNummer);
                     
                  when False =>
                     null;
               end case;
         end case;
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
            return;

         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleLebenspunkte <= 0 then
            return;
               
         else
            Karte.AnzeigeKarte (RasseExtern => RasseExtern);
         end if;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   


   -- 1 = Bewegung auf Feld möglich.
   -- 0 = Außerhalb der Karte oder Feld blockiert durch eigene Einheit.
   -- -1 = Gegnerische Einheit oder Stadt auf dem Feld.
   function ZwischenEbene (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin

      KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition,
                                                        Änderung      => (0, YÄnderung, XÄnderung),
                                                        ZusatzYAbstand => 0);

      case KartenWert.YAchse is
         when GlobaleDatentypen.Kartenfeld'First =>
            return 0;
            
         when others =>      
            FeldPassierbar := FeldFürDieseEinheitPassierbar (RasseExtern   => RasseExtern,
                                                              EinheitNummer => EinheitNummer,
                                                              YPosition     => KartenWert.YAchse,
                                                              XPosition     => KartenWert.XAchse);
      end case;

      case FeldPassierbar is
         when True =>
            null;
            
         when False =>
            return 0;
      end case;

      GegnerWert := BefindetSichDortEineEinheit (RasseExtern  => RasseExtern,
                                                 YPosition    => KartenWert.YAchse,
                                                 XPosition    => KartenWert.XAchse);

      if GegnerWert.Rasse = RasseExtern and GegnerWert.Platznummer = 1 then
         return 0;

      elsif GegnerWert.Platznummer = SchleifenPruefungen.RückgabeWert or GegnerWert.Platznummer = 0 then
         return 1;
         
      else
         return -1;
      end if;
      
   end ZwischenEbene;



   function FeldFürDieseEinheitPassierbar (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      
      if EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit = 3 then
         null;
               
      elsif EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit
        /= KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, YPosition, XPosition).Grund).Passierbarkeit then
         case EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).Passierbarkeit is
            when 2 =>
               Stadtnummer := SchleifenPruefungen.KoordinatenStadtMitRasseSuchen (RasseExtern  => RasseExtern,
                                                                                  Koordinaten  => (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, YPosition, XPosition));
         
               case Stadtnummer is
                  when 0 =>
                     return False;
               
                  when others =>
                     null;
               end case;
                     
            when others =>
               return False;
         end case;
            
      else
         null;
      end if;

      return True;
      
   end FeldFürDieseEinheitPassierbar;
   
   
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord is
   begin

      GegnerEinheitWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => (0, YPosition, XPosition));

      if GegnerEinheitWert.Rasse = RasseExtern then
         return (GegnerEinheitWert.Rasse, 1);

      elsif GegnerEinheitWert.Rasse = GlobaleDatentypen.RassenMitNullwert'First then
         null;
                  
      else
         return GegnerEinheitWert;
      end if;

      GegnerStadtWert := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (Koordinaten => (0, YPosition, XPosition));

      if GegnerStadtWert.Rasse = RasseExtern then
         return (GegnerStadtWert.Rasse, 0);
         
      else
         return GegnerStadtWert;
      end if;
      
   end BefindetSichDortEineEinheit;

   

   procedure BewegungEinheitenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).VerbesserungStraße /= 0
        and Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).VerbesserungStraße <= 19 then
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 0.50;

      elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).Fluss /= 0 then
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 0.50;

      elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).VerbesserungStraße > 19 then   
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte - 1.00;

      elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).Grund = 1
        or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).Grund = 7
        or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).Grund = 9
        or Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, YPosition, XPosition).Grund = 32 then
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

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse := YPosition;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse := XPosition;               
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := YPosition;
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := XPosition;
                       
   end BewegungEinheitenBerechnung;

end BewegungssystemEinheiten;
