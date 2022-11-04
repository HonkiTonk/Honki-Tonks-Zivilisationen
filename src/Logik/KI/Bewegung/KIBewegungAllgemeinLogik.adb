pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with EinheitenDatentypen;
with EinheitenKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with DiplomatischerZustandLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;

package body KIBewegungAllgemeinLogik is

   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
   is begin
      
      BlockierendeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => FeldKoordinatenExtern,
                                                                                   LogikGrafikExtern => True);
      BlockierendeStadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => FeldKoordinatenExtern).Rasse;
      
      if
        BlockierendeEinheit.Rasse = EinheitenKonstanten.LeerRasse
        and
          BlockierendeStadt = EinheitenKonstanten.LeerRasse
      then
         return KIKonstanten.BewegungNormal;
         
      elsif
        BlockierendeEinheit.Rasse = EinheitRasseNummerExtern.Rasse
      then
         return KIKonstanten.Tauschbewegung;
         
      elsif
        BlockierendeStadt = EinheitRasseNummerExtern.Rasse
      then
         return KIKonstanten.BewegungNormal;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return KIKonstanten.KeineBewegung;
            
         when others =>
            return FeldAngreifen (EigeneEinheitExtern          => EinheitRasseNummerExtern,
                                  FeindlicheRasseEinheitExtern => BlockierendeEinheit.Rasse,
                                  FeindlicheRasseStadtExtern   => BlockierendeStadt);
      end case;
      
   end FeldBetreten;
   
   
   
   -- Hier nochmal besser unterscheiden mit was angegeriffen wird? äöü
   function FeldAngreifen
     (EigeneEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindlicheRasseEinheitExtern : in RassenDatentypen.Rassen_Enum;
      FeindlicheRasseStadtExtern : in RassenDatentypen.Rassen_Enum)
      return KIDatentypen.Bewegung_Enum
   is begin
      
      if
        FeindlicheRasseEinheitExtern = EinheitenKonstanten.LeerRasse
        and then
          DiplomatieDatentypen.Krieg_Enum /= DiplomatischerZustandLogik.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneEinheitExtern.Rasse,
                                                                                                     FremdeRasseExtern => FeindlicheRasseStadtExtern)
      then
         return KIKonstanten.KeineBewegung;
         
      elsif
        FeindlicheRasseStadtExtern = EinheitenKonstanten.LeerRasse
        and then
          DiplomatieDatentypen.Krieg_Enum /= DiplomatischerZustandLogik.DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneEinheitExtern.Rasse,
                                                                                                     FremdeRasseExtern => FeindlicheRasseEinheitExtern)
      then
         return KIKonstanten.KeineBewegung;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EigeneEinheitExtern)
      is
         when KIDatentypen.Angreifen_Enum | KIDatentypen.Verbesserung_Zerstören_Enum | KIDatentypen.Erkunden_Enum | KIDatentypen.Verteidigen_Enum =>
            return KIKonstanten.BewegungAngriff;
            
         when others =>
            return KIKonstanten.KeineBewegung;
      end case;
      
   end FeldAngreifen;

end KIBewegungAllgemeinLogik;
