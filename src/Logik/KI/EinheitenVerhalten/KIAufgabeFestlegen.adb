pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenRecords; use KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;

with KIDatentypen;
with KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseStadtGebaut;
with LeseEinheitenGebaut;
with LeseKarten;

with KartePositionPruefen;
with BewegungPassierbarkeitPruefen;
with StadtBauen;
with EinheitSuchen;
with DiplomatischerZustand;

with KIPruefungen;
with KIMindestBewertungKartenfeldErmitteln;
with KIAufgabenVerteilt;
with KIFeindlicheEinheitSuchen;
with KIStadtSuchen;
with KIBewegungAllgemein;
with KISonstigesSuchen;

package body KIAufgabeFestlegen is
   
   procedure KeineAufgabe
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Hier eventuell die Bewegungspukte auf 0 setzen?
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern      => SystemDatentypen.Leer);
      
   end KeineAufgabe;
   
   

   procedure Heilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Heilen);
      
   end Heilen;
   
   
   
   procedure StadtBauenPrüfung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      NeueStadtPosition := KIPruefungen.UmgebungStadtBauenPrüfen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                   MindestBewertungFeldExtern => KIMindestBewertungKartenfeldErmitteln.MindestBewertungKartenfeldStadtBauen
                                                                     (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        NeueStadtPosition = KIKonstanten.LeerKoordinate
      then
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        NeueStadtPosition.XAchse /= KartenKonstanten.LeerXAchse
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Verbesserung_Anlegen);
      SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end StadtUmgebungVerbesserung;
   
   
   
   procedure StadtBewachen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when KartenDatentypen.Leer =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         case
           EinheitNummer
         is
            when EinheitenKonstanten.LeerNummer =>
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungZerstören;
   
   
   
   procedure Angreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WenAngreifen := ZielErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      case
        WenAngreifen
      is
         when EinheitenKonstanten.LeerRasse =>
            return;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Angreifen);
      end case;
      
      KoordinatenFeind := KIFeindlicheEinheitSuchen.FeindlicheEinheitInUmgebungSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       FeindExtern              => WenAngreifen);
      
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
            return;
      end case;
      
      KoordinatenFeind := KIStadtSuchen.NähesteFeindlicheStadtSuchen (RasseExtern             => WenAngreifen,
                                                                       AnfangKoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KIKonstanten.LeerKoordinate);
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
      end case;
      
   end Angreifen;
   
   
   
   function ZielErmitteln
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
   is begin
      
      Ziel := EinheitenKonstanten.LeerRasse;
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Leer
           or
             RasseSchleifenwert = RasseExtern
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = SystemDatentypen.Krieg
         then
            -- Hier noch mehr Überprüfungen einbauen?
            Ziel := RasseSchleifenwert;
            exit RassenSchleife;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return Ziel;
      
   end ZielErmitteln;
   
   
   
   procedure Erkunden
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
                    KartenWert.XAchse = KartenKonstanten.LeerXAchse
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
                                                 KoordinatenExtern        => KIKonstanten.LeerKoordinate);
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts);
      
   end Erkunden;
   
   
   
   procedure Fliehen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Flucht);
      
   end Fliehen;
   
   
   
   procedure Befestigen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Festsetzen);
      
   end Befestigen;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      PlatzGefunden := KISonstigesSuchen.EigenesFeldSuchen (AktuellePositionExtern   => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                            EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        PlatzGefunden.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Verbessern);
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert),
                                                        EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
               if
                 PlatzGefunden.XAchse = KartenKonstanten.LeerXAchse
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
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Verbessern);
      end case;
      
   end EinheitVerbessern;
   
   
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      Umgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebung .. Umgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebung .. Umgebung loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                                         NeuePositionExtern       => KartenWert)
              = False
            then
               null;
               
            elsif
              KIBewegungAllgemein.FeldBetreten (FeldPositionExtern       => KartenWert,
                                                EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
                /= 0
            then
               null;
               
            else
               return KartenWert;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.LeerKoordinate;
      
   end EinheitVerbessernPlatz;

end KIAufgabeFestlegen;
