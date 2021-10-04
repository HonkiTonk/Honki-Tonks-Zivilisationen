pragma SPARK_Mode (On);

with SchreibeEinheitenGebaut, SchreibeWichtiges;
with LeseEinheitenDatenbank;

with Sichtbarkeit, RasseEntfernen, EinheitenModifizieren;

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
         when GlobaleDatentypen.Arbeiter =>
            SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when GlobaleDatentypen.Nahkämpfer | GlobaleDatentypen.Fernkämpfer | GlobaleDatentypen.Beides =>
            SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when GlobaleDatentypen.Sonstiges =>
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
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => -1);

      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end EinheitEntfernen;

end EinheitenErzeugenEntfernen;
