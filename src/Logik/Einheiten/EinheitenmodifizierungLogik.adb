pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with StadtSuchenLogik;
with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with StadtproduktionLogik;
with ForschungstestsLogik;

with KIDatentypen; use KIDatentypen;

package body EinheitenmodifizierungLogik is

   -- Wäre es sinnvoll sowas zu parallelisieren? äöü
   -- Könnte was bringen bei vielen Einheiten? äöü
   procedure HeilungBewegungspunkteNeueRundeErmitteln
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
           
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                              
                  case
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
                  is
                     when EinheitenKonstanten.LeerID =>
                        null;
                  
                     when others =>
                        HeilungBewegungspunkteNeueRundeSetzen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end case;
            
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteNeueRundeErmitteln;



   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AktuelleBeschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      KIBeschäftigung := LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      if
        AktuelleBeschäftigung = AufgabenDatentypen.Heilen_Enum
        or
          AktuelleBeschäftigung = AufgabenDatentypen.Verschanzen_Enum
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate,
                                               RechnenSetzenExtern      => True);
         
      elsif
        AktuelleBeschäftigung = AufgabenDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                       IDExtern    => EinheitID)
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate / 2,
                                               RechnenSetzenExtern      => True);
         
      else
         null;
      end if;
      
      case
        AktuelleBeschäftigung
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => EinheitID),
                                                     RechnenSetzenExtern      => False);

         when others =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => False);
      end case;
      
   end HeilungBewegungspunkteNeueRundeSetzen;
   
      
   
   procedure PermanenteKostenÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Heimatstadt
      is
         when StadtDatentypen.MaximaleStädteMitNullWert'First =>
            return;
            
         when others =>
            AktuelleID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         if
           0 > LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                        IDExtern           => AktuelleID,
                                                        WelcheKostenExtern => PermanenteKostenSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt),
                                                        WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                        KostenExtern           =>
                                                          ProduktionDatentypen.Stadtproduktion (VorzeichenWechselExtern)  * LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                                     IDExtern           => AktuelleID,
                                                                                                                                                                     WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt));
      
   end PermanenteKostenÄndern;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                  KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell,
                                                                                  LogikGrafikExtern => True);
      
            NeueHeimatstadt.Rasse := EinheitRasseNummerExtern.Rasse;
            NeueHeimatstadt.Nummer := StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                       KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell);
            
         when others =>
            EinheitNummer := EinheitRasseNummerExtern.Nummer;
            
            NeueHeimatstadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      end case;
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        or
          NeueHeimatstadt.Nummer = StadtKonstanten.LeerNummer
          or
            EinheitRasseNummerExtern.Rasse /= NeueHeimatstadt.Rasse
      then
         return;
         
      elsif
        NeueHeimatstadt.Nummer = LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))
      then
         return;
         
      else
         PermanenteKostenÄndern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                                  VorzeichenWechselExtern  => -1);
      
         SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                                              HeimatstadtExtern        => NeueHeimatstadt.Nummer);
      
         PermanenteKostenÄndern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                                  VorzeichenWechselExtern  => 1);
      end if;
      
   end HeimatstadtÄndern;
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is begin
      
      if
        IDExtern = EinheitenKonstanten.LeerID
      then
         return False;
         
      elsif
        EinheitenDatentypen.Cheat_Enum = LeseEinheitenDatenbank.Einheitenart (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                              IDExtern    => IDExtern)
      then
         return SpielVariablen.Debug.VolleInformation;
         
      elsif
        False = PassierbarkeitspruefungLogik.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                        EinheitenIDExtern      => IDExtern)
      then
         return False;
         
      else
         return ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                           TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                      IDExtern    => IDExtern));
      end if;
      
   end EinheitAnforderungenErfüllt;

end EinheitenmodifizierungLogik;
