with DiplomatieDatentypen;
with EinheitenDatentypen;
with EinheitenKonstanten;
with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseDiplomatie;

with EinheitSuchenLogik;
with StadtSuchenLogik;

with KIKonstanten;

package body KIBewegungAllgemeinLogik is

   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
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
         Aufgabe := LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         if
           LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = AufgabenDatentypen.Leer_Aufgabe_Enum
           and
             (Aufgabe = KIDatentypen.Leer_Aufgabe_Enum
              or
                Aufgabe = KIDatentypen.Platz_Machen_Enum
              or
                Aufgabe = KIDatentypen.Einheit_Auflösen_Enum
              or
                Aufgabe = KIDatentypen.Erkunden_Enum)
         then
            return KIKonstanten.Tauschbewegung;
            
         else
            return KIKonstanten.KeineBewegung;
         end if;
         
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
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      if
        FeindlicheRasseEinheitExtern = EinheitenKonstanten.LeerRasse
        and then
          DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (RasseEinsExtern => EigeneEinheitExtern.Rasse,
                                                                              RasseZweiExtern => FeindlicheRasseStadtExtern)
      then
         return KIKonstanten.KeineBewegung;
         
      elsif
        FeindlicheRasseStadtExtern = EinheitenKonstanten.LeerRasse
        and then
          DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (RasseEinsExtern => EigeneEinheitExtern.Rasse,
                                                                              RasseZweiExtern => FeindlicheRasseEinheitExtern)
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
