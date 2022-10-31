pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with EinheitenDatentypen;
with EinheitenKonstanten;

with KIKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with SchreibeEinheitenGebaut;

with DiplomatischerZustandLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;
with Vergleiche;

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
         case
           Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => FeldKoordinatenExtern,
                                            KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
         is
            when True =>
               EinheitWegbewegen (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                                  StehendeEinheitExtern  => BlockierendeEinheit);
               
            when False =>
               null;
         end case;
         
         return KIKonstanten.KeineBewegung;
         
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
   
   
   
   procedure EinheitWegbewegen
     (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => StehendeEinheitExtern)
      is
         when KIDatentypen.Tut_Nichts_Enum | KIDatentypen.Leer_Aufgabe_Enum =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => StehendeEinheitExtern,
                                                    AufgabeExtern            => KIDatentypen.Platz_Machen_Enum);
            
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => BewegendeEinheitExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => False);
            
         when others =>
            null;
      end case;
      
   end EinheitWegbewegen;
   
   
   
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
