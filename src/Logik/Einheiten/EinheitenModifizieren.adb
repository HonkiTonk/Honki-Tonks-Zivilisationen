pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with StadtSuchen;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with StadtProduktion;
with ForschungAllgemein;

with KIDatentypen; use KIDatentypen;

package body EinheitenModifizieren is

   -- Wäre es sinnvoll sowas zu parallelisieren? äöü
   procedure HeilungBewegungspunkteNeueRundeErmitteln
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
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

      if
        AktuelleBeschäftigung = AufgabenDatentypen.Heilen_Enum
        or
          AktuelleBeschäftigung = AufgabenDatentypen.Verschanzen_Enum
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate,
                                               RechnenSetzenExtern      => 1);
         
      elsif
        AktuelleBeschäftigung = AufgabenDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                       IDExtern    => LeseEinheitenGebaut.ID
                                                                                                                                                         (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate / 2,
                                               RechnenSetzenExtern      => 1);
         
      else
         null;
      end if;
      
      case
        AktuelleBeschäftigung
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => LeseEinheitenGebaut.ID
                                                                                                                                   (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                     RechnenSetzenExtern      => 0);

         when others =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
      end case;
      
      case
        KIBeschäftigung
      is
         when KIDatentypen.Tut_Nichts_Enum =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
            
         when others =>
            null;
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
                                                          ProduktionDatentypen.Stadtproduktion (VorzeichenWechselExtern) * LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                                    IDExtern           => AktuelleID,
                                                                                                                                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt));
      
   end PermanenteKostenÄndern;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell);
            
         when others =>
            EinheitNummer := EinheitRasseNummerExtern.Nummer;
      end case;
      
      StadtNummerNeu := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                    KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell);
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        or
          StadtNummerNeu = StadtKonstanten.LeerNummer
      then
         return;
         
      elsif
        StadtNummerNeu = LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))
      then
         return;
         
      else
         null;
      end if;
      
      PermanenteKostenÄndern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                               VorzeichenWechselExtern  => -1);
      
      SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                                           HeimatstadtExtern        => StadtNummerNeu);
      
      PermanenteKostenÄndern (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                               VorzeichenWechselExtern  => 1);
      
   end HeimatstadtÄndern;
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
   is begin
      
      if
        False = BewegungPassierbarkeitPruefen.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                         EinheitenIDExtern      => IDExtern)
      then
         return False;
         
      elsif
        SpielVariablen.Debug.VolleInformation = False
        and
          EinheitenDatentypen.Cheat_Enum = LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                              IDExtern    => IDExtern)
      then
         return False;
         
      elsif
        SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
        and
          EinheitenDatentypen.Cheat_Enum = LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                              IDExtern    => IDExtern)
      then
         return False;
         
      else
         return ForschungAllgemein.TechnologieVorhanden (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                         TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                    IDExtern    => IDExtern));
      end if;
      
   end EinheitAnforderungenErfüllt;

end EinheitenModifizieren;
