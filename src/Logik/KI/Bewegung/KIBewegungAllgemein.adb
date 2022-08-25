pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with EinheitenKonstanten;
with SystemDatentypen; use SystemDatentypen;

with KIKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with DiplomatischerZustand;
with EinheitSuchen;
with StadtSuchen;

package body KIBewegungAllgemein is

   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
   is begin
      
      BlockierendeEinheit := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => FeldKoordinatenExtern).Rasse;
      BlockierendeStadt := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => FeldKoordinatenExtern).Rasse;
      
      if
        BlockierendeEinheit = EinheitenKonstanten.LeerRasse
        and
          BlockierendeStadt = EinheitenKonstanten.LeerRasse
      then
         return KIKonstanten.BewegungNormal;
         
      elsif
        BlockierendeEinheit = EinheitRasseNummerExtern.Rasse
      then
         return KIKonstanten.KeineBewegung;
         
      elsif
        BlockierendeStadt = EinheitRasseNummerExtern.Rasse
      then
         return KIKonstanten.BewegungNormal;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return KIKonstanten.KeineBewegung;
            
         when others =>
            return FeldAngreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end FeldBetreten;
   
   
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
   is begin
      
      if
        BlockierendeEinheit = EinheitenKonstanten.LeerRasse
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeStadt)
        /= SystemDatentypen.Krieg_Enum
      then
         return KIKonstanten.KeineBewegung;
         
      elsif
        BlockierendeStadt = EinheitenKonstanten.LeerRasse
        and then
          DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             FremdeRasseExtern => BlockierendeEinheit)
        /= SystemDatentypen.Krieg_Enum
      then
         return KIKonstanten.KeineBewegung;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Angreifen_Enum | KIDatentypen.Verbesserung_Zerstören_Enum | KIDatentypen.Erkunden_Enum | KIDatentypen.Verteidigen_Enum =>
            return KIKonstanten.BewegungAngriff;
            
         when others =>
            return KIKonstanten.KeineBewegung;
      end case;
      
   end FeldAngreifen;

end KIBewegungAllgemein;