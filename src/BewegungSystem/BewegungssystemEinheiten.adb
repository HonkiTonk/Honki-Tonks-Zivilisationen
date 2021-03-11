pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleKonstanten;

with Karte, EinheitenDatenbank, Diplomatie, Sichtbarkeit, VerbesserungenDatenbank, KartenPruefungen, BewegungEinheitenMoeglichPruefen;

package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummer.Rasse);

      BewegenSchleife:
      loop
      
         Get_Immediate (Item => Richtung);
         Richtung := To_Lower (Item => Richtung);
              
         case Richtung is
            when 'w' | '8' =>
               Änderung := (0, -1, 0);
            
            when 'a' | '4' =>
               Änderung := (0, 0, -1);
            
            when 's' | '2' =>
               Änderung := (0, 1, 0);
            
            when 'd' | '6'  =>
               Änderung := (0, 0, 1);
            
            when '1' =>
               Änderung := (0, 1, -1);

            when '3' =>
               Änderung := (0, 1, 1);
            
            when '7' =>
               Änderung := (0, -1, -1);
            
            when '9' =>
               Änderung := (0, -1, 1);

            when '+' =>
               Änderung := (1, 0, 0);
               
            when '-' =>
               Änderung := (-1, 0, 0);
            
            when others =>
               return;
         end case;
         
         RückgabeWert := ZwischenEbene (EinheitRasseNummer => EinheitRasseNummer,
                                         ÄnderungExtern     => Änderung);

         case RückgabeWert is
            when 1 => -- Einheit wurde bewegt.          
               Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummer => EinheitRasseNummer);
               
            when others => -- Einheit wurde nicht bewegt.
               null;
         end case;
         
         if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte = 0.00 then
            return;

         elsif GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleLebenspunkte <= 0 then
            return;
               
         else
            Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummer.Rasse);
         end if;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   


   -- 1 = Bewegung auf Feld möglich.
   -- 0 = Außerhalb der Karte, Feld blockiert durch eigene Einheit oder Kampf gegen gegnerische Einheit verloren.
   -- -1 = Gegnerische Einheit oder Stadt auf dem Feld.
   function ZwischenEbene (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => ÄnderungExtern,
                                                              ZusatzYAbstand => 0);

      case KartenWert.Erfolgreich is
         when False =>
            return 0;
            
         when True =>
            FeldPassierbar := BewegungEinheitenMoeglichPruefen.FeldFürDieseEinheitPassierbar (EinheitRasseNummer => EinheitRasseNummer,
                                                                                               NeuePosition       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
      end case;

      case FeldPassierbar is
         when True =>
            null;
            
         when False =>
            return 0;
      end case;

      GegnerWert := BewegungEinheitenMoeglichPruefen.BefindetSichDortEineEinheit (RasseExtern   => EinheitRasseNummer.Rasse,
                                                                                  NeuePosition  => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

      if GegnerWert.Rasse = EinheitRasseNummer.Rasse and GegnerWert.Platznummer = 1 then
         return 0;

      elsif GegnerWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch then
         BewegungEinheitenBerechnung (EinheitRasseNummer => EinheitRasseNummer,
                                      NeuePosition       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
         return 1;
         
      else
         ErgebnisGegnerAngreifen := Diplomatie.GegnerAngreifenOderNicht (EinheitRasseNummer => EinheitRasseNummer,
                                                                         Gegner             => GegnerWert);

         case ErgebnisGegnerAngreifen is
            when True =>
               BewegungEinheitenBerechnung (EinheitRasseNummer => EinheitRasseNummer,
                                            NeuePosition       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
               return 1;
               
            when False =>
               return 0;
         end case;
      end if;
      
   end ZwischenEbene;

   

   procedure BewegungEinheitenBerechnung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) is
   begin
      
      case StraßeUndFlussPrüfen (EinheitRasseNummer => EinheitRasseNummer,
                                   NeuePosition          => NeuePosition) is         
         when 1 | 2 =>
            BewegungspunkteModifikator := 0.50;
            
         when 10 | 11 =>
            BewegungspunkteModifikator := 1.00;

         when others =>
            BewegungspunkteModifikator := 0.00;
      end case;

      case Karten.Weltkarte (NeuePosition.EAchse, NeuePosition.YAchse, NeuePosition.XAchse).Grund is
         when  1 | 7 | 9 | 32 =>
            if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte < 1.00 then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte := 0.00;
               return;
                     
            else                     
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte - 2.00 + BewegungspunkteModifikator;
            end if;
               
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte - 1.00 + BewegungspunkteModifikator;
      end case;

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte < 0.00 then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte := 0.00;
                  
      else
         null;
      end if;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition := NeuePosition;
      GlobaleVariablen.CursorImSpiel (EinheitRasseNummer.Rasse).AchsenPosition := NeuePosition;
      
   end BewegungEinheitenBerechnung;



   function StraßeUndFlussPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Integer is
   begin

      if EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).Passierbarkeit (1) = True and
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).Passierbarkeit (3) = False then
         BonusBeiBewegung := 0;

         case Karten.Weltkarte (NeuePosition.EAchse, NeuePosition.YAchse, NeuePosition.XAchse).VerbesserungStraße is
            when 5 .. 19 =>
               BonusBeiBewegung := BonusBeiBewegung + 1;

            when 20 .. VerbesserungenDatenbank.VerbesserungListe'Last =>
               BonusBeiBewegung := BonusBeiBewegung + 10;
                  
            when others =>
               null;
         end case;               

         case Karten.Weltkarte (NeuePosition.EAchse, NeuePosition.YAchse, NeuePosition.XAchse).Fluss is
            when 0 =>
               null;

            when others =>
               BonusBeiBewegung := BonusBeiBewegung + 1;
         end case;
            
         return BonusBeiBewegung;

      else
         return 0;
      end if;
      
   end StraßeUndFlussPrüfen;

end BewegungssystemEinheiten;
