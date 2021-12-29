pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeWichtiges;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with Sichtbarkeit;
with RasseEntfernen;
with EinheitenModifizieren;

package body EinheitenErzeugenEntfernen is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                  IDExtern                 => IDExtern);
      
      SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                        PositionExtern           => KoordinatenExtern);
      
      SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                           HeimatstadtExtern        => StadtRasseNummerExtern.Platznummer);
      
      SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                            LebenspunkteExtern       =>
                                              LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern    => IDExtern),
                                            RechnenSetzenExtern      => 0);
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                               BewegungspunkteExtern    =>
                                                 LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                 IDExtern    => IDExtern),
                                               RechnenSetzenExtern      => 0);
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
      is
         when EinheitStadtDatentypen.Arbeiter =>
            SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when EinheitStadtDatentypen.Nahkämpfer | EinheitStadtDatentypen.Fernkämpfer | EinheitStadtDatentypen.Beides =>
            SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when EinheitStadtDatentypen.Sonstiges =>
            SchreibeWichtiges.AnzahlSonstiges (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                               PlusMinusExtern => True);
            
         when others =>
            null;
      end case;
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                     VorzeichenWechselExtern  => 1);
      
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      
   end EinheitErzeugen;



   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitEntfernenLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      Entfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end EinheitEntfernen;
   
   
   
   procedure EinheitEntfernenLadung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
        
         EinheitNummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => LadungSchleifenwert);
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
         then
            null;
            
         else
            Entfernen (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer));
         end if;
         
      end loop TransporterSchleife;
               
   end EinheitEntfernenLadung;
   
   
   
   procedure Entfernen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => -1);

      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Entfernen;

end EinheitenErzeugenEntfernen;
