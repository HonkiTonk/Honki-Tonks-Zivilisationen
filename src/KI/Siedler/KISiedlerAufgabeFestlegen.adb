pragma SPARK_Mode (On);

with KIDatentypen, KIKonstanten;

with EinheitenDatenbank;

with StadtBauen, KIPruefungen;

package body KISiedlerAufgabeFestlegen is

   procedure SiedlerAufgabeFestlegen
     (GewählteAufgabeExtern : in Natural;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GewählteAufgabeExtern
      is
         when 1 => -- Stadt bauen
            StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 2 => -- Stadtumgebung verbessern
            StadtUmgebungVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 3 => -- Einheit auflösen
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 4 => -- Fliehen
            Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 5 => -- Sich heilen
            Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 6 => -- Sich befestigen
            Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 7 => -- Einheit verbessern
            EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others => -- Nichts tun
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
      end case;
      
   end SiedlerAufgabeFestlegen;
   


   procedure StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln
        EinheitRasseNummerExtern.Rasse in 1 .. 5
      then
         MindestBewertungKartenfeld := 90;
            
      else
         MindestBewertungKartenfeld := 90;
      end if;
      
      NeueStadtPosition := KIPruefungen.UmgebungStadtBauenPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                   MindestBewertungFeldExtern => MindestBewertungKartenfeld);
      
      if
        NeueStadtPosition = KIKonstanten.NullKoordinate
      then
         StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        NeueStadtPosition.YAchse /= 0
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := (NeueStadtPosition.EAchse, NeueStadtPosition.YAchse, NeueStadtPosition.XAchse);
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         
      else
         null;
      end if;
   
   end StadtBauenPrüfung;
   
   
   
   procedure StadtUmgebungVerbesserung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Verbesserung_Anlegen;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
        := KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end StadtUmgebungVerbesserung;
   
   
   
   procedure Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin      
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Flucht;
      
   end Fliehen;
     
   
   
   procedure Heilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Heilen;
      
   end Heilen;
   
   
   
   procedure Befestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Festsetzen;
      
   end Befestigen;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Verbessern;
      
   end EinheitVerbessern;

end KISiedlerAufgabeFestlegen;
