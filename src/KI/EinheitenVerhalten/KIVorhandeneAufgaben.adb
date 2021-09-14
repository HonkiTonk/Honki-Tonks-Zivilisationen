pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseWichtiges, LeseRassenDatenbank, LeseStadtGebaut;

with EinheitSuchen, DiplomatischerZustand;

with KIAufgabenVerteilt, KIPruefungen;

package body KIVorhandeneAufgaben is

   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        = LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
      then
         return 0;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 3 * 2
      then
         return 3;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitID)
        / 2
      then
         return 5;
         
      elsif
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = 1
      then
         return 10;
         
      else
         return 8;
      end if;
      
   end SichHeilen;
   
   
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      NotwendigeTechnologie := LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NotwendigeTechnologie
      is
         when GlobaleDatentypen.EinheitenIDMitNullWert'First =>
            return 0;
            
         when others =>
            null;
      end case;
      
      if
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => NotwendigeTechnologie)
        = True
      then
         return 3;
            
      else
         return 0;
      end if;
      
   end SichVerbessern;
   


   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      VorhandeneStädte := LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen);
         return 11;
         
      elsif
        GlobaleVariablen.RundenAnzahl
          > (Positive (VorhandeneStädte)
             + KIAufgabenVerteilt.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen))
        * 20
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen);
         return 5;
         
      else
         null;
      end if;
      
      if
        LeseRassenDatenbank.RassenExpansion (EinheitRasseNummerExtern.Rasse) > 10
      then
         return 3;
         
      else
         return 2;
      end if;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      case
        KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            return 0;
            
         when others =>
            return 5;
      end case;  
            
   end StadtUmgebungVerbessern;
   
   
   
   function StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         if
           EinheitNummer = GlobaleKonstanten.LeerEinheitStadtNummer
           and
             KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen,
                                                    RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                    ZielKoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)))
           = False
         then
            return 10;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
                                    
   end StadtBewachen;
   
   
   
   function StadtUmgebungZerstören
     return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
      
   end StadtUmgebungZerstören;
   
   
   
   function Angreifen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
           or
             RasseSchleifenwert = EinheitRasseNummerExtern.Rasse
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = GlobaleDatentypen.Krieg
         then
            return 5;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return 0;
      
   end Angreifen;
   
   
   
   function Erkunden
     return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      return 2;
      
   end Erkunden;
   
   
   
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      if
        18 + LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse)
        < LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse)
      then
         return 3;
         
      else
         null;
      end if;
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
        
      case
        Heimatstadt
      is
         when 0 =>
            return 0;

         when others =>
            null;
      end case;

      KostenSchleife:
      for KostenSchleifenwert in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                    IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                    WelcheKostenExtern => KostenSchleifenwert)
           = GlobaleKonstanten.NullPermanenteKosten
         then
            null;
            
         else
            return 1;
         end if;
         
      end loop KostenSchleife;
                     
      return 0;
      
   end EinheitAuflösen;
   
                                    
   
   function Fliehen
     return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
                                    
   end Fliehen;
   
   
   
   function SichBefestigen
     return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      return 0;
      
   end SichBefestigen;
   
   

   function NichtsTun
     return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      return 1;
      
   end NichtsTun;

end KIVorhandeneAufgaben;
