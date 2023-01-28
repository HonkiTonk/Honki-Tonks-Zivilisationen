with ProduktionDatentypen;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with PassierbarkeitspruefungLogik;
with StadtproduktionLogik;
with ForschungstestsLogik;
with DebugobjekteLogik;
with KartenfeldereffekteLogik;

package body EinheitenmodifizierungLogik is

   -- Wäre es sinnvoll sowas zu parallelisieren? äöü
   -- Könnte was bringen bei vielen Einheiten? äöü
   procedure HeilungBewegungspunkteNeueRundeErmitteln
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
           
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesSchleifenwert) loop
                              
                  case
                    LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesSchleifenwert, EinheitNummerSchleifenwert))
                  is
                     when EinheitenKonstanten.LeerID =>
                        null;
                  
                     when others =>
                        HeilungBewegungspunkteNeueRundeSetzen (EinheitSpeziesNummerExtern => (SpeziesSchleifenwert, EinheitNummerSchleifenwert));
                  end case;
            
               end loop EinheitenSchleife;
         end case;
         
      end loop SpeziesSchleife;
      
   end HeilungBewegungspunkteNeueRundeErmitteln;



   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type EinheitenDatentypen.Bewegungspunkte;
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      AktuelleBeschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      KIBeschäftigung := LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      Feldeffekt := KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));

      if
        Feldeffekt = False
        and
          (AktuelleBeschäftigung = AufgabenDatentypen.Heilen_Enum
           or
             AktuelleBeschäftigung = AufgabenDatentypen.Verschanzen_Enum)
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate,
                                               RechnenSetzenExtern      => True);
         
      elsif
        Feldeffekt = False
        and
          AktuelleBeschäftigung = AufgabenDatentypen.Leer_Aufgabe_Enum
          and
            LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                                             IDExtern    => EinheitID)
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               LebenspunkteExtern       => Heilungsrate / 2,
                                               RechnenSetzenExtern      => True);
         
      else
         null;
      end if;
      
      case
        AktuelleBeschäftigung
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            if
              Feldeffekt = False
            then
               SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        BewegungspunkteExtern      => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                      IDExtern      => EinheitID),
                                                        RechnenSetzenExtern        => False);
               
            else
               SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        BewegungspunkteExtern      => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                      IDExtern      => EinheitID)
                                                        / 2,
                                                        RechnenSetzenExtern        => False);
            end if;

         when others =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern        => False);
      end case;
      
   end HeilungBewegungspunkteNeueRundeSetzen;
   
      
   
   procedure PermanenteKostenÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Heimatstadt
      is
         when StadtDatentypen.MaximaleStädteMitNullWert'First =>
            return;
            
         when others =>
            AktuelleID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         if
           0 > LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                        IDExtern           => AktuelleID,
                                                        WelcheKostenExtern => PermanenteKostenSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt),
                                                        WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                        KostenExtern           =>
                                                          ProduktionDatentypen.Stadtproduktion (VorzeichenWechselExtern) * LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                                                    IDExtern           => AktuelleID,
                                                                                                                                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt));
      
   end PermanenteKostenÄndern;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitNummer := EinheitSpeziesNummerExtern.Nummer;
            
      NeueHeimatstadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      if
        NeueHeimatstadt.Nummer = StadtKonstanten.LeerNummer
        or
          EinheitSpeziesNummerExtern.Spezies /= NeueHeimatstadt.Spezies
      then
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenWechselExtern  => -1);
      
         SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                              HeimatstadtExtern          => StadtKonstanten.LeerNummer);
         return;
         
      elsif
        NeueHeimatstadt.Nummer = LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer))
      then
         return;
         
      else
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenWechselExtern  => -1);
      
         SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                              HeimatstadtExtern          => NeueHeimatstadt.Nummer);
      
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenWechselExtern  => 1);
      end if;
      
   end HeimatstadtÄndern;
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type EinheitenDatentypen.Einheitart_Enum;
   begin
      
      if
        IDExtern = EinheitenKonstanten.LeerID
      then
         return False;
         
      elsif
        EinheitenDatentypen.Cheat_Enum = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                              IDExtern    => IDExtern)
      then
         return DebugobjekteLogik.Debug.VolleInformation;
         
      elsif
        False = PassierbarkeitspruefungLogik.RichtigeUmgebungVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                        EinheitenIDExtern      => IDExtern)
      then
         return False;
         
      else
         return ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern       => StadtSpeziesNummerExtern.Spezies,
                                                           TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                      IDExtern    => IDExtern));
      end if;
      
   end EinheitAnforderungenErfüllt;

end EinheitenmodifizierungLogik;
