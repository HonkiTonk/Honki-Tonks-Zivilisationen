pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with EinheitenKonstanten;

with KIDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with DiplomatischerZustand;
with EinheitSuchen;
with StadtSuchen;

package body KIBewegungAllgemein is

   -- -1 = Belegt und Angriff, 0 = Unbelegt, 1 = Belegt und kein Angriff
   function FeldBetreten
     (FeldPositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.LoopRangeMinusEinsZuEins
   is begin
      
      BlockierendeEinheit := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => FeldPositionExtern).Rasse;
      BlockierendeStadt := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => FeldPositionExtern).Rasse;
      
      if
        BlockierendeEinheit = EinheitenKonstanten.LeerRasse
        and
          BlockierendeStadt = EinheitenKonstanten.LeerRasse
      then
         return 0;
         
      elsif
        BlockierendeEinheit = EinheitRasseNummerExtern.Rasse
      then
         return 1;
         
      elsif
        BlockierendeStadt = EinheitRasseNummerExtern.Rasse
      then
         return 0;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitStadtDatentypen.Leer | EinheitStadtDatentypen.Arbeiter =>
            return 1;
            
         when others =>
            return FeldAngreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end FeldBetreten;
   
   
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.LoopRangeMinusEinsZuEins
   is begin
      
      if
        BlockierendeEinheit = EinheitenKonstanten.LeerRasse
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeStadt)
        /= SystemDatentypen.Krieg
      then
         return 1;
         
      elsif
        BlockierendeStadt = EinheitenKonstanten.LeerRasse
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeEinheit)
        /= SystemDatentypen.Krieg
      then
         return 1;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Angreifen | KIDatentypen.Verbesserung_Zerstören | KIDatentypen.Erkunden | KIDatentypen.Verteidigen =>
            return -1;
            
         when others =>
            return 1;
      end case;
      
   end FeldAngreifen;

end KIBewegungAllgemein;
