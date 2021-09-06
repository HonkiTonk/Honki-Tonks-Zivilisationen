pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen, KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseStadtGebaut, LeseEinheitenGebaut, LeseKarten;

with KartePositionPruefen, BewegungPassierbarkeitPruefen, BewegungBlockiert, StadtBauen, EinheitSuchen, DiplomatischerZustand;

with KIPruefungen, KIMindestBewertungKartenfeldErmitteln, KIAufgabenVerteilt;

package body KIAufgabeFestlegen is
   
   procedure KeineAufgabe
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      -- Hier eventuell die Bewegungspukte auf 0 setzen?
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern      => GlobaleDatentypen.Leer);
      
   end KeineAufgabe;
   
   

   procedure Heilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Heilen);
      
   end Heilen;
   
   
   
   procedure StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NeueStadtPosition := KIPruefungen.UmgebungStadtBauenPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                   MindestBewertungFeldExtern => KIMindestBewertungKartenfeldErmitteln.MindestBewertungKartenfeldStadtBauen
                                                                     (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        NeueStadtPosition = KIKonstanten.NullKoordinate
      then
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
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
   
   
   
   procedure StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
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
         
         case
           EinheitNummer
         is
            when GlobaleKonstanten.LeerEinheitStadtNummer =>
               SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          KoordinatenExtern        => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AufgabeExtern            => KIDatentypen.Stadt_Bewachen);
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end StadtBewachen;
   
   
   
   procedure StadtUmgebungZerstören     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungZerstören;
   
   
   
   procedure Angreifen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
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
            -- Hier noch mehr Überprüfungen einbauen?
            WenAngreifen := RasseSchleifenwert;
            exit RassenSchleife;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      
      
   end Angreifen;
   
   
   
   procedure Erkunden     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin      
            
      KarteReichweite := 1;
      KarteGeprüft := KarteReichweite - 1;
      
      UnbekanntesFeldSuchenSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -KarteReichweite .. KarteReichweite loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -KarteReichweite .. KarteReichweite loop
            
               if
                 KarteGeprüft >= abs (YÄnderungSchleifenwert)
                 or
                   KarteGeprüft >= abs (XÄnderungSchleifenwert)
               then
                  null;
                  
               else
                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                              ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                  
                  if
                    KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                  then
                     null;
                        
                  elsif
                    LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                         RasseExtern    => EinheitRasseNummerExtern.Rasse)
                    = False
                    and
                      BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                 NeuePositionExtern       => KartenWert)
                    = True
                    and
                      KIAufgabenVerteilt.EinheitZiel (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                      ZielKoordinatenExtern => KartenWert)
                    = False
                  then
                     SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                KoordinatenExtern        => KartenWert);
                     SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             AufgabeExtern            => KIDatentypen.Erkunden);
                     return;
                     
                  else
                     null;
                  end if;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         exit UnbekanntesFeldSuchenSchleife when KarteReichweite > 15;
         
         KarteGeprüft := KarteReichweite;
         KarteReichweite := KarteReichweite + 1;
         
      end loop UnbekanntesFeldSuchenSchleife;
      
      SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => KIKonstanten.NullKoordinate);
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts);
      
   end Erkunden;
   
   
   
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
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      PlatzGefunden := KIKonstanten.NullKoordinate;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert),
                                                        EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
               if
                 PlatzGefunden.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
         end case;
                               
      end loop StadtSchleife;
      
      case
        PlatzGefunden.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Verbessern);
      end case;
      
   end EinheitVerbessern;
   
   
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      Umgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebung .. Umgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebung .. Umgebung loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                                         NeuePositionExtern       => KartenWert)
              = False
            then
               null;
               
            elsif
              BewegungBlockiert.FeldBlockiert (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                               NeuePositionExtern       => KartenWert)
              = True
            then
               null;
               
            else
               return KartenWert;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.NullKoordinate;
      
   end EinheitVerbessernPlatz;

end KIAufgabeFestlegen;
