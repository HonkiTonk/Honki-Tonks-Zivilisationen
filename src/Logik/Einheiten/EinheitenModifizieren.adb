pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;

with StadtSuchen;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with StadtProduktion;

package body EinheitenModifizieren is

   procedure HeilungBewegungspunkteNeueRundeErmitteln
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
               null;
           
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                              
                  if
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = EinheitenKonstanten.LeerEinheit.ID
                  then
                     null;
                  
                  else
                     HeilungBewegungspunkteNeueRundeSetzen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end if;
            
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteNeueRundeErmitteln;



   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AktuelleBeschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        AktuelleBeschäftigung = SystemKonstanten.LeerTastenbelegungKonstante
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                  RechnenSetzenExtern      => 0);

      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                                  RechnenSetzenExtern      => 0);
      end if;

      case
        AktuelleBeschäftigung
      is
         when SystemKonstanten.HeilenKonstante | SystemKonstanten.VerschanzenKonstante =>
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  LebenspunkteExtern       => Heilungsrate,
                                                  RechnenSetzenExtern      => 1);
            
         when others =>
            null;
      end case;
      
   end HeilungBewegungspunkteNeueRundeSetzen;
   
   
   
   procedure PermanenteKostenÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Heimatstadt
      is
         when EinheitStadtDatentypen.MaximaleStädteMitNullWert'First =>
            return;
            
         when others =>
            AktuelleID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in EinheitStadtRecords.PermanenteKostenArray'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                    IDExtern           => AktuelleID,
                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert)
           <= 0
         then
            null;
            
         else
            SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt),
                                                        WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                        KostenExtern           =>
                                                          GesamtePermanenteKosten (VorzeichenWechselExtern) * LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                       IDExtern           => AktuelleID,
                                                                                                                                                       WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt));
      
   end PermanenteKostenÄndern;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Platznummer
      is
         when EinheitenKonstanten.LeerNummer =>
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position);
            
         when others =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
      end case;
      
      StadtNummerNeu := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                    KoordinatenExtern => GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position);
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        or
          StadtNummerNeu = EinheitenKonstanten.LeerNummer
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Boolean
   is begin
      
      case
        BewegungPassierbarkeitPruefen.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 EinheitenIDExtern      => IDExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        = ForschungKonstanten.LeerForschungAnforderung
      then
         null;
         
      elsif
        LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        = ForschungKonstanten.ForschungUnmöglich
      then
         return False;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                  IDExtern    => IDExtern))
        = True
      then
         null;
         
      else
         return False;
      end if;
      
      return True;
      
   end EinheitAnforderungenErfüllt;

end EinheitenModifizieren;
