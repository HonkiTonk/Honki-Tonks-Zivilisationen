pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with StadtKonstanten;
with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenKonstanten;

with LeseStadtGebaut;
with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with PassierbarkeitspruefungLogik;
with ForschungstestsLogik;
with KartenkoordinatenberechnungssystemLogik;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KISonstigesSuchenLogik;
with KIBewegungAllgemeinLogik;

package body KIEinheitFestlegenModernisierenLogik is

   -- Hier wird weder geprüft ob das Feld schon belegt ist, noch ob sich eine andere Einheit bereits dahin befindet. äöü
   -- Muss prüfen ob die Heimatstadt das mitmacht und die Geldgewinnung. Und natürlich ob eine benötigte Ressource vorhanden ist. äöü
   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NeueEinheitenID := LeseEinheitenDatenbank.VerbesserungZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NeueEinheitenID
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            null;
      end case;
      
      case
        ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                   TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                              IDExtern    => NeueEinheitenID))
      is
         when False =>
            return False;
              
         when True =>
            PlatzGefunden := KISonstigesSuchenLogik.EigenesFeldSuchen (AktuelleKoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                       EinheitRasseNummerExtern  => EinheitRasseNummerExtern);
      end case;
            
      case
        PlatzGefunden.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Verbessern_Enum);
            return True;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'Range (2) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert),
                                                        EinheitNummerExtern    => EinheitRasseNummerExtern.Nummer);
               
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
            return False;
            
         when others =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => PlatzGefunden);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Verbessern_Enum);
            return True;
      end case;
      
   end EinheitVerbessern;
   
   
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Umgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebung .. Umgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebung .. Umgebung loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                                                NeueKoordinatenExtern    => KartenWert)
            then
               null;
               
            elsif
              KIKonstanten.BewegungNormal /= KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => KartenWert,
                                                                                    EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern))
            then
               null;
               
            else
               return KartenWert;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end EinheitVerbessernPlatz;

end KIEinheitFestlegenModernisierenLogik;
