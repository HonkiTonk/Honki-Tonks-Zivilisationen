pragma SPARK_Mode (On);

with KartenPruefungen, BewegungEinheitenMoeglichPruefen, GlobaleKonstanten, Diplomatie;

package body BewegungZwischenEbene is

   function PassierbarkeitOderTransporter (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
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

      return FeldPassierbar;

   end PassierbarkeitOderTransporter;



   function Gegner (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin
      
      GegnerWert := BewegungEinheitenMoeglichPruefen.BefindetSichDortEineEinheit (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                                                  NeuePositionExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

      if GegnerWert.Rasse = EinheitRasseNummerExtern.Rasse and GegnerWert.Platznummer = 1 then
         return 0;

      elsif GegnerWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch then
         -- BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     -- NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
         return 1;
         
      else
         ErgebnisGegnerAngreifen := Diplomatie.GegnerAngreifenOderNicht (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         GegnerExtern             => GegnerWert);

         case ErgebnisGegnerAngreifen is
            when True =>
               -- BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            -- NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
               return 1;
               
            when False =>
               return 0;
         end case;
      end if;
      
   end Gegner;

end BewegungZwischenEbene;
