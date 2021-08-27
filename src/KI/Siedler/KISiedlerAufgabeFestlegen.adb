pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen, KIKonstanten;

with SchreibeEinheitenGebaut;

with StadtBauen, KIPruefungen, EinheitenAllgemein, KIMindestBewertungKartenfeldErmitteln, KIAufgabenFestlegenAllgemein;

package body KISiedlerAufgabeFestlegen is

   procedure SiedlerAufgabeFestlegen
     (GewählteAufgabeExtern : in Natural;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GewählteAufgabeExtern
      is
         -- Stadt bauen
         when 1 =>
            StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Stadtumgebung verbessern
         when 2 =>
            StadtUmgebungVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Einheit auflösen
         when 3 =>
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Fliehen
         when 4 =>
            Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Sich heilen
         when 5 =>
            KIAufgabenFestlegenAllgemein.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Sich befestigen
         when 6 =>
            Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Einheit verbessern
         when 7 =>
            KIAufgabenFestlegenAllgemein.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Nichts tun
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Leer);
      end case;
      
   end SiedlerAufgabeFestlegen;
   


   procedure StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NeueStadtPosition := KIPruefungen.UmgebungStadtBauenPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                   MindestBewertungFeldExtern => KIMindestBewertungKartenfeldErmitteln.MindestBewertungKartenfeldStadtBauen
                                                                     (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        NeueStadtPosition = KIKonstanten.NullKoordinate
      then
         StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        NeueStadtPosition.XAchse /= GlobaleKonstanten.LeerYXKartenWert
      then
         SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => NeueStadtPosition);
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Stadt_Bauen);
         
      else
         null;
      end if;
   
   end StadtBauenPrüfung;
   
   
   
   procedure StadtUmgebungVerbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Verbesserung_Anlegen);
      SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end StadtUmgebungVerbesserung;
   
   
   
   procedure Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Flucht);
      
   end Fliehen;
   
   
   
   procedure Befestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Festsetzen);
      
   end Befestigen;

end KISiedlerAufgabeFestlegen;
