with SchreibeEinheitenGebaut;
with SchreibeWichtiges;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with SichtbarkeitsberechnungssystemLogik;
with SpeziesEntfernenLogik;
with EinheitenmodifizierungLogik;

package body EinheitenErzeugenEntfernenLogik is

   procedure EinheitErzeugen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Standardwerte (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern),
                                             IDExtern                   => IDExtern,
                                             KoordinatenExtern          => KoordinatenExtern,
                                             StadtNummerExtern          => StadtSpeziesNummerExtern.Nummer);
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                             IDExtern      => IDExtern)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => True);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => True);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                               PlusMinusExtern => True);
      end case;
      
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern),
                                                           VorzeichenWechselExtern    => 1);
      
      SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürEinheit (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerExtern));
      
   end EinheitErzeugen;



   procedure EinheitEntfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      EinheitEntfernenLadung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      Entfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      SpeziesEntfernenLogik.SpeziesExistenzPrüfen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
   end EinheitEntfernen;
   
   
   
   procedure EinheitEntfernenLadung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      TransporterSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
        
         EinheitNummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlatzExtern                => LadungSchleifenwert);
         
         if
           EinheitNummer = EinheitenKonstanten.LeerNummer
         then
            null;
            
         else
            Entfernen (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer));
         end if;
         
      end loop TransporterSchleife;
               
   end EinheitEntfernenLadung;
   
   
   
   procedure Entfernen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           VorzeichenWechselExtern    => -1);
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            SchreibeWichtiges.AnzahlArbeiter (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => False);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            SchreibeWichtiges.AnzahlKämpfer (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                              PlusMinusExtern => False);
            
         when others =>
            SchreibeWichtiges.AnzahlSonstiges (SpeziesExtern   => EinheitSpeziesNummerExtern.Spezies,
                                               PlusMinusExtern => False);
      end case;

      SchreibeEinheitenGebaut.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Entfernen;

end EinheitenErzeugenEntfernenLogik;
