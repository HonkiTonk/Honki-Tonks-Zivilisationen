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
with EinheitenmodifizierungLogik;

package body EinheitenErzeugenEntfernenLogik is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Standardwerte (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                             IDExtern                 => IDExtern,
                                             KoordinatenExtern        => KoordinatenExtern,
                                             StadtNummerExtern        => StadtRasseNummerExtern.Nummer);
            
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                              PlusMinusExtern => True);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                               PlusMinusExtern => True);
      end case;
      
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
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
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
        
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
      
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           VorzeichenWechselExtern  => -1);
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                              PlusMinusExtern => False);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                              PlusMinusExtern => False);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                               PlusMinusExtern => False);
      end case;

      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Entfernen;

end EinheitenErzeugenEntfernenLogik;