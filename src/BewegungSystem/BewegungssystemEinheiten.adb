pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleKonstanten;

with Karte, EinheitenDatenbank, Diplomatie, Sichtbarkeit, VerbesserungenDatenbank, KartenPruefungen, BewegungEinheitenMoeglichPruefen, BewegungZwischenEbene, EinheitSuchen;

package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

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

         RückgabeWert := BewegungZwischenEbene.PassierbarkeitOderTransporter (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               ÄnderungExtern          => Änderung);
         
         case RückgabeWert is
            when 1 => -- Da ist ein Transporter mit freiem Platz
               TransporterBeladen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   ÄnderungExtern           => Änderung);
               return;
               
            when 0 => -- Einheit kann sich auf das Feld bewegen
               null;
               
            when -1 => -- Bewegung dahin nicht möglich und da ist keine Stadt/Transporter auf die die Einheit sich bewegen kann
               EinheitBewegtNichtEingeladen := False;
         end case;




         case EinheitBewegtNichtEingeladen is
            when True => -- Einheit wurde bewegt.          
               Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when False => -- Einheit wurde nicht bewegt.
               null;
         end case;
         
         if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte = 0.00 then
            return;

         elsif GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte <= 0 then
            return;
               
         else
            Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
         end if;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   


   function ZwischenEbene (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);

      case KartenWert.Erfolgreich is
         when False =>
            return -1;
            
         when True =>
            FeldPassierbar := BewegungEinheitenMoeglichPruefen.FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                  NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
      end case;

      
      
      

      GegnerWert := BewegungEinheitenMoeglichPruefen.BefindetSichDortEineEinheit (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                                                  NeuePositionExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

      if GegnerWert.Rasse = EinheitRasseNummerExtern.Rasse and GegnerWert.Platznummer = 1 then
         return 0;

      elsif GegnerWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch then
         BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
         return 1;
         
      else
         ErgebnisGegnerAngreifen := Diplomatie.GegnerAngreifenOderNicht (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         GegnerExtern             => GegnerWert);

         case ErgebnisGegnerAngreifen is
            when True =>
               BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
               return 1;
               
            when False =>
               return 0;
         end case;
      end if;
      
   end ZwischenEbene;



   procedure TransporterBeladen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) is
   begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);
      
      EinheitNummerTransporter := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                  KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
      
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
        
         case GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerTransporter).Transportiert (FreierPlatzSchleifenwert) is
            when 0 =>
               null;
               
            when others =>
               FreierPlatzNummer := FreierPlatzSchleifenwert;
               exit TransporterSchleife;
         end case;
         
      end loop TransporterSchleife;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerTransporter).Transportiert (FreierPlatzNummer) := EinheitRasseNummerExtern.Platznummer;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerTransporter).AchsenPosition;
      
   end TransporterBeladen;

   

   procedure BewegungEinheitenBerechnung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) is
   begin
      
      case StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 NeuePositionExtern       => NeuePositionExtern) is         
         when 1 | 2 =>
            BewegungspunkteModifikator := 0.50;
            
         when 10 | 11 =>
            BewegungspunkteModifikator := 1.00;

         when others =>
            BewegungspunkteModifikator := 0.00;
      end case;

      case Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund is
         when  1 | 7 | 9 | 32 =>
            if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte < 1.00 then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
               return;
                     
            else                     
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte - 2.00 + BewegungspunkteModifikator;
            end if;
               
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte - 1.00 + BewegungspunkteModifikator;
      end case;

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte < 0.00 then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
                  
      else
         null;
      end if;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition := NeuePositionExtern;
      GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).AchsenPosition := NeuePositionExtern;
      
   end BewegungEinheitenBerechnung;



   function StraßeUndFlussPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Integer is
   begin

      if EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (1) = True and
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (3) = False then
         BonusBeiBewegung := 0;

         case Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).VerbesserungStraße is
            when 5 .. 19 =>
               BonusBeiBewegung := BonusBeiBewegung + 1;

            when 20 .. VerbesserungenDatenbank.VerbesserungListe'Last =>
               BonusBeiBewegung := BonusBeiBewegung + 10;
                  
            when others =>
               null;
         end case;               

         case Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Fluss is
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
