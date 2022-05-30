pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                  IDExtern                 => IDExtern);
      
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                           KoordinatenExtern        => KoordinatenExtern);
      
      SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                           HeimatstadtExtern        => StadtRasseNummerExtern.Nummer);
      
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
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when EinheitenDatentypen.Nahkämpfer_Enum | EinheitenDatentypen.Fernkämpfer_Enum | EinheitenDatentypen.Beides_Enum =>
            SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when EinheitenDatentypen.Sonstiges_Enum =>
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      EinheitEntfernenLadung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      Entfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end EinheitEntfernen;
   
   
   
   procedure EinheitEntfernenLadung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => -1);

      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Entfernen;

end EinheitenErzeugenEntfernen;
