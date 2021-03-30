pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenPruefungen, BewegungEinheitenMoeglichPruefen, EinheitSuchen;

package body BewegungZwischenEbene is

   function PassierbarOderTransporter (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.Bewegung_Enum is
   begin

      return GlobaleDatentypen.Keine_Bewegung_Möglich;
      
   end PassierbarOderTransporter;

   function PassierbarkeitOderTransporter (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);

      case
        KartenWert.Erfolgreich
      is
         when False =>
            return -1;
            
         when True =>
            FeldPassierbar := BewegungEinheitenMoeglichPruefen.FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                  NeuePositionExtern       => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
            return FeldPassierbar;
      end case;

   end PassierbarkeitOderTransporter;



   -- 0 = Einheit kann sich auf das Feld bewegen
   -- -1 = Bewegung dahin nicht möglich da von eigener Einheit blockiert oder Einheit im Kampf vernichtet
   -- 1 = Da ist ein Feind
   function Gegner (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins is
   begin
      
      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);

      EinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

      if
        EinheitWert.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return -1;

      elsif
        EinheitWert.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         return 0;
         
      else
         return 1;
      end if;
      
   end Gegner;

end BewegungZwischenEbene;
